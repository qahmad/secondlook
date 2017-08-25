class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])

    @videos = @user.videos  

    render("users/show.html.erb")

  end
end
