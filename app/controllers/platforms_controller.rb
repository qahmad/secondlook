class PlatformsController < ApplicationController
  def index
    @platforms = Platform.page(params[:page]).per(10)

    render("platforms/index.html.erb")
  end

  def show
    @video = Video.new
    @platform = Platform.find(params[:id])

    render("platforms/show.html.erb")
  end

  def new
    @platform = Platform.new

    render("platforms/new.html.erb")
  end

  def create
    @platform = Platform.new

    @platform.name = params[:name]
    @platform.embed_link = params[:embed_link]

    save_status = @platform.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/platforms/new", "/create_platform"
        redirect_to("/platforms")
      else
        redirect_back(:fallback_location => "/", :notice => "Platform created successfully.")
      end
    else
      render("platforms/new.html.erb")
    end
  end

  def edit
    @platform = Platform.find(params[:id])

    render("platforms/edit.html.erb")
  end

  def update
    @platform = Platform.find(params[:id])

    @platform.name = params[:name]
    @platform.embed_link = params[:embed_link]

    save_status = @platform.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/platforms/#{@platform.id}/edit", "/update_platform"
        redirect_to("/platforms/#{@platform.id}", :notice => "Platform updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Platform updated successfully.")
      end
    else
      render("platforms/edit.html.erb")
    end
  end

  def destroy
    @platform = Platform.find(params[:id])

    @platform.destroy

    if URI(request.referer).path == "/platforms/#{@platform.id}"
      redirect_to("/", :notice => "Platform deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Platform deleted.")
    end
  end
end
