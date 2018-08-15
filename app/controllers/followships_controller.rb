class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
     unless params[:following_id] ==current_user.id 
      if @followship.save
        @user = User.find(@followship.following_id)
        #redirect_back fallback_location: root_path, notice: "follow success"
      else
        #flash[:alert] = @followship.errors.full_messages.to_sentence
        #redirect_back fallback_location: root_path
      end
    end
  end

  
