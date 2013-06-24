class SessionsController < ApplicationController
  def new
    if params[:voter]
      flash.now[:notice] = "Please sign in before you vote."
    end
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or root_path
    else
      flash.now[:error] = "Invalid email/password combo!"
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success] = "Successfully signed out."
    redirect_to root_path
  end


end
