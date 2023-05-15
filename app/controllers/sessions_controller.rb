class SessionsController < ApplicationController
  def new

  end

  def create
    # search for the user
    user = User.find_by(email: params[:session][:email].downcase)
    # verify if the user and password are equivalent
    if user && user.authenticate(params[:session][:password])
      # keep the user logged in
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to user
    else
      flash.now[:alert] = "There was something wrong with your login details"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
end
