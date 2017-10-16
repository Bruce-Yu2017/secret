class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
    @user = User.find(session[:user_id])
  end

  def create
    Secret.create(secret_params)
    redirect_to "/users/#{session[:user_id]}"

  end
  def destroy
    @secret = Secret.find(params[:id])
    @secret.destroy if @secret.user === current_user
    redirect_to "/users/#{session[:user_id]}"
  end

  private
  def secret_params
    params.require(:secret).permit(:content, :user_id)
  end
end
