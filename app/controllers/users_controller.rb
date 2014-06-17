class UsersController < ApplicationController
  def timeline
  end
  def profile
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
