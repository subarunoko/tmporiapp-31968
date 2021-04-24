class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :likes, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :user

  #devise ユーザー編集       
  def update_without_current_password(params, *options)
    params.delete(:current_password)
    # binding.pry
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end


  #ユーザーをフォローする
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follower_id: other_user.id)
    end
  end

  #ユーザーのフォローを外す
  def unfollow(other_user)
    relationship = self.relationships.find_by(follower_id: other_user.id)
    relationship.destroy if relationship
  end

  #フォローしていればtrueを返す
  def following?(other_user)
    self.followings.include?(other_user)
  end

end