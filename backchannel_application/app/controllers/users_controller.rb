class UsersController < ApplicationController
  def index

  end
  def show
    @users = User.all
  end
  def new
    @user = User.new

  end
  def create
    @user = User.new(params[:user])
    #@user.temp_u = params[:temp_u]
    if(params[:is_admin] == "1")
      @user.is_admin = 1
    end
    if(params[:is_admin] == "0")
      @user.is_admin = 0
    end
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
  def edit

  end
  def update

  end
  def destroy
    user = User.find(params[:id])
    if user && current_user.is_admin == 1 && user.username != "prateek"
    user.destroy
    redirect_to root_url, :notice => "user deleted"
    else
    redirect_to root_url, :notice => "cant delete user"
      end
  end
end
