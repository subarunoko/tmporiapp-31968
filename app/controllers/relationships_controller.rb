class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      # flash[:success] = "成功"
      redirect_to @user
    else
      # flash[:alert] = "失敗"
      redirect_to @user
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      redirect_to @user
    else
      redirect_to @user
    end
  end


  private

  def set_user
    @user = User.find(params[:follower_id])
  end

end

