class UsersController < ApplicationController
  skip_before_action :login, only: [:new, :create]
  before_action :match_id, only: [:show, :update, :edit, :destroy]
  def new
  end

  def show
    @user = User.find(params[:id])
    @all_secrets = @user.secrets
  end

  def create
    @user = User.new(user_params)
    if @user.save
      
      redirect_to "/sessions/new"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/new"
    end
  end

  def edit
    @user = User.find(params[:id])    
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_updated_params)
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    redirect_to "/users/new"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_updated_params
    params.require(:user).permit(:name, :email)
  end

  def match_id
    if params[:id] != session[:user_id]
      redirect_to "/users/#{session[:user_id]}"
    end
  end
end
