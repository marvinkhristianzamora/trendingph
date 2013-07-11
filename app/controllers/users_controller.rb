class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to newmakersPH!"
        format.html { redirect_to root_path }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render 'new' }
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
