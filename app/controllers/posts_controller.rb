class PostsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def index
    if signed_in?
      @post = current_user.posts.build
    elsif
      @user = User.new
    end
    @posts = Post.list.paginate(page: params[:page], per_page: 10)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html do
          flash[:success] = "Posted!"
          redirect_to root_path
        end
        format.json { render json: { success: true, post: @post }, status: :created, location: @post }
        format.js
      else
        format.json { render json: { success: false, errors: @post.errors } }
        format.html { render 'new' }
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:url, :title, :content)
  end
end
