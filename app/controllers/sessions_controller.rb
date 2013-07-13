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

        format.json { render json: user, status: :created, location: user }
      else
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
