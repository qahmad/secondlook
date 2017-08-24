class VideosController < ApplicationController
  def index
    @videos = Video.all

    render("videos/index.html.erb")
  end

  def show
    @video = Video.find(params[:id])

    render("videos/show.html.erb")
  end

  def new
    @video = Video.new

    render("videos/new.html.erb")
  end

  def create
    @video = Video.new

    @video.caption = params[:caption]
    @video.videolink = params[:videolink]
    @video.starttime = params[:starttime]
    @video.user_id = params[:user_id]
    @video.platform_id = params[:platform_id]

    save_status = @video.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/videos/new", "/create_video"
        redirect_to("/videos")
      else
        redirect_back(:fallback_location => "/", :notice => "Video created successfully.")
      end
    else
      render("videos/new.html.erb")
    end
  end

  def edit
    @video = Video.find(params[:id])

    render("videos/edit.html.erb")
  end

  def update
    @video = Video.find(params[:id])

    @video.caption = params[:caption]
    @video.videolink = params[:videolink]
    @video.starttime = params[:starttime]
    @video.user_id = params[:user_id]
    @video.platform_id = params[:platform_id]

    save_status = @video.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/videos/#{@video.id}/edit", "/update_video"
        redirect_to("/videos/#{@video.id}", :notice => "Video updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Video updated successfully.")
      end
    else
      render("videos/edit.html.erb")
    end
  end

  def destroy
    @video = Video.find(params[:id])

    @video.destroy

    if URI(request.referer).path == "/videos/#{@video.id}"
      redirect_to("/", :notice => "Video deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Video deleted.")
    end
  end
end
