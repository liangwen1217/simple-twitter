class TweetsController < ApplicationController

  before_action :set_tweet, only: [:like, :unlike]
  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweetsbuild(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      flash[:alert] = @tweet.errors.full_message.to_sentence
      @tweets = Tweet.all.order(created_at: :desc)
      render :index
    end
  end

  def like
    @like = Like.where(user: current_user, tweet: @tweet).first
    @like.destroy
    redirect_back fallback_location: root_path
  end

  def unlike
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:id])
    
  end
  def tweet_params
    params.require(:tweet).permit(:description)
    
  end

end
