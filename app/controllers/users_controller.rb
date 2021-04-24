class UsersController < ApplicationController
  before_action :set_user, only: [:show] 
  before_action :authenticate_user!, except: [:show]

  def index
  end

  def show
    # @nickname = @user.nickname
    # binding.pry
    @article = Article.where(user_id: params[:id])
    @like = Like.where(user_id: params[:id])
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:id])
  end



end
