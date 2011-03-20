class VideosController < ApplicationController
  def index
    @videos = current_user.videos
  end

  def new
    @video = current_user.videos.build
  end

  def edit
    @video = current_user.videos.find(params[:id])
  end

  def create
    @video = current_user.videos.build(params[:video])
    if @video.save
      redirect_to videos_path, :notice => "Successfully create a new video."
    else
      render :new
    end
  end

  def update
    @video = current_user.videos.find(params[:id])
    if @video.update_attributes(params[:video])
      redirect_to videos_path, :notice => "Successfully updated the video."
    else
      render :edit
    end
  end

  def destroy
    @video = current_user.videos.find(params[:id])
    @video.destroy
    redirect_to videos_path, :notice => "Successfully deleted video."
  end
end
