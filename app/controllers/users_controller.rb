class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :likes, :followings, :]

  def tweets
    @tweets = user.tweets.order(created_at: :desc)
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Profile Updated"
    else
      flash[:alert] = @user.errors.full_messages.to_sentence

      render :edit
  end

  def followings
    @followings = @user.followings.includes(:followships).order("followships.updated_at desc")# 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.includes(:followships).order("followships.updated_at desc") # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.like_tweets.includes(:likes).order("likes.created_at desc")# 基於測試規格，必須講定變數名稱
  end

  private
  def set_user
    @user = User.find(params[:id])
    
  end
  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
    
  end
end
