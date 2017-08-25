require 'uri'
require 'video_info'

class VideosController < ApplicationController
  before_action :current_user_must_be_video_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_video_user
    video = Video.find(params[:id])

    unless current_user == video.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = Video.ransack(params[:q])
    @videos = @q.result(:distinct => true).includes(:tags, :comments, :user, :platform).page(params[:page]).per(10)

    render("videos/index.html.erb")
  end

  def show
    @comment = Comment.new
    @tag = Tag.new
    @video = Video.find(params[:id])

    render("videos/show.html.erb")
  end

  def new
    @video = Video.new

    @videohour = 0
    @videomin = 0
    @videosec = 0

    render("videos/new.html.erb")
  end

  def create
    @video = Video.new

    @video.caption = params[:caption]
    @video.videolink = params[:videolink]
    @video.user_id = params[:user_id]
    @video.platform_id = params[:platform_id]

    # @video.starttime = params[:starttime]
    @video.starttime = (params[:videohour].to_i * 3600) + (params[:videomin].to_i * 60) + (params[:videosec].to_i)


    if "youtu".in? @video.videolink.downcase

      query_string = URI.parse(@video.videolink).query
      parameters = Hash[URI.decode_www_form(query_string)]
      
      @video.videolink = parameters['v'] #@video.platform.embed_link + parameters['v'] + '?start=' + @video.starttime.to_s
      
      # Couldn't get video_info gem to work; leaving code below to come back and try another day
      # v = VideoInfo.new(@video.videolink).duration
      # @video.starttime = v.duration

    end

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

    @videohour = Time.at(@video.starttime).utc.strftime("%H").to_i.to_s
    @videomin = Time.at(@video.starttime).utc.strftime("%M").to_i.to_s
    @videosec = Time.at(@video.starttime).utc.strftime("%S").to_i.to_s

    render("videos/edit.html.erb")
  end

  def update
    @video = Video.find(params[:id])

    @video.caption = params[:caption]
    @video.videolink = params[:videolink]
    @video.user_id = params[:user_id]
    @video.platform_id = params[:platform_id]

    # @video.starttime = params[:starttime]
    @video.starttime = (params[:videohour].to_i * 3600) + (params[:videomin].to_i * 60) + (params[:videosec].to_i)

    if "youtu".in? @video.videolink.downcase

      query_string = URI.parse(@video.videolink).query
      parameters = Hash[URI.decode_www_form(query_string)]
      
      @video.videolink = parameters['v'] #@video.platform.embed_link + parameters['v'] + '?start=' + @video.starttime.to_s
      
      # Couldn't get video_info gem to work; leaving code below to come back and try another day
      # v = VideoInfo.new(@video.videolink).duration
      # @video.starttime = v.duration

    end


    save_status = @video.save

    if save_status == true
      #referer = URI(request.referer).path
      

      #case referer
      #when "/videos/#{@video.id}/edit", "/update_video"
        redirect_to("/videos/#{@video.id}", :notice => "Video updated successfully.")
      #else
        #redirect_back(:fallback_location => "/", :notice => "Video updated successfully.")
      #end
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
