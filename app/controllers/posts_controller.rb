class PostsController < ApplicationController
  before_action :signed_in_user, only: [:new]

  def new
    @post = Post.new
  end
end
