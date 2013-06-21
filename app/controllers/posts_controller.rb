class PostsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def index
    @posts = Post.list
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Posted!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def post_params
    params.require(:post).permit(:url, :title, :content)
  end
end
