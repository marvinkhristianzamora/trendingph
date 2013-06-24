class VotesController < ApplicationController
  before_action :signed_in_user

  def create
    @post = Post.find(params[:vote][:post_id])
    @post.vote_from!(current_user)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
