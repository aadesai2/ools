class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user
      session[:username] = user.username
      redirect_to posts_path , :notice => "Login Successful."
    else
      flash.now.alert = "Invalid username or password"
      render "new"
    # flash.now.alert = "Incorrect password"
    end

  end

  def destroy
    session[:username] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
