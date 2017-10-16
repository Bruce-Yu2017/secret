class SessionsController < ApplicationController
  skip_before_action :login, except: [:destroy]
  def new
  end

  def create
    # Log User In
    # if authenticate true
        # save user id to session
        # redirect to users profile page
    # if authenticate false
        # add an error message -> flash[:errors] = ["Invalid"]
        # redirect to login page
    @user = User.find_by_email(params[:email]).try(:authenticate, params[:password])   
    if @user
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
    else
      if User.find_by_email(params[:email]) == nil
        flash[:errors] = ["Can't find this email"]
      else
        flash[:errors] = ["Incorrect password"]
      end      
      redirect_to "/sessions/new"
    end

  end
def destroy
    # Log User out
    # set session[:user_id] to null
    # redirect to login page
    session[:user_id] = nil
    redirect_to "/sessions/new"
end

end
