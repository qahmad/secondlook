class TagsController < ApplicationController
  before_action :current_user_must_be_tag_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_tag_user
    tag = Tag.find(params[:id])

    unless current_user == tag.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @tags = current_user.tags.page(params[:page]).per(10)

    render("tags/index.html.erb")
  end

  def show
    @tag = Tag.find(params[:id])

    render("tags/show.html.erb")
  end

  def new
    @tag = Tag.new

    render("tags/new.html.erb")
  end

  def create
    @tag = Tag.new

    @tag.user_id = params[:user_id]
    @tag.video_id = params[:video_id]

    save_status = @tag.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/tags/new", "/create_tag"
        redirect_to("/tags")
      else
        redirect_back(:fallback_location => "/", :notice => "Tag created successfully.")
      end
    else
      render("tags/new.html.erb")
    end
  end

  def edit
    @tag = Tag.find(params[:id])

    render("tags/edit.html.erb")
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.video_id = params[:video_id]

    save_status = @tag.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/tags/#{@tag.id}/edit", "/update_tag"
        redirect_to("/tags/#{@tag.id}", :notice => "Tag updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Tag updated successfully.")
      end
    else
      render("tags/edit.html.erb")
    end
  end

  def destroy
    @tag = Tag.find(params[:id])

    @tag.destroy

    if URI(request.referer).path == "/tags/#{@tag.id}"
      redirect_to("/", :notice => "Tag deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Tag deleted.")
    end
  end
end
