class LikesController < ApplicationController
  before_action :set_article, only:[:create, :destroy]
  before_action :authenticate_user!

  def create
    @like = Like.create(user_id: current_user.id, article_id: params[:id])
    # @like = Like.create(user_id: current_user.id, article_id: @article.id)
    render 'create.js.erb'
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, article_id: params[:id])
    # @like = Like.find_by(user_id: current_user.id, article_id: @article.id)
    @like.delete
    # binding.pry
    render 'destory.js.erb'
  end


  private

  def set_article
    @article = Article.find(params[:id])
    @id_name = "#like-btn-#{@article.id}"
  end

end
