class SessionsController < ApplicationController
  def new
    if params[:voter]
      flash.now[:notice] = "Please sign in before you vote."
    end
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        sign_in user
        flash[:success] = "Hey you, welcome back!"
        format.html do
          redirect_back_or root_path
        end

        format.json { render json: { success: true }, status: :created, location: user }
        format.js
      else
        format.json { render json: { success: false, error_message: "Invalid email/password combo!" },
          status: :created, location: user }
        format.html do
          flash.now[:error] = "Invalid email/password combo!"
          render 'new'
        end
      end
    end
  end

  def destroy
    sign_out
    flash[:success] = "Successfully signed out."
    redirect_to root_path
  end


end
