class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def timeline
  end
  def profile
    if params[:username] == "websocket"
      respond_to do |format|
        # format.html #render show.html.erb
        # format.json
        # format.js { render json: @article, callback: params[:callback] }
      end
    else
      @user       = User.find_by_username params[:username]
      @following  = @user.all_follows
      @follower   = @user.followers
      @articles   = @user.articles
      @questions  = @user.questions
      @quotes     = @user.quotes
      @activities = PublicActivity::Activity.all.where(owner: current_user)
      @template   = "profile"
    end
  end
end
