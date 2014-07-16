class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :ensure_signup_complete , only: [:profile, :timeline]
  
  def timeline
  end
  def profile
    @user       = User.find_by_username params[:username]
    # @following  = @user.all_follows
    # @follower   = @user.followers
    # @articles   = @user.articles
    # @questions  = @user.questions
    # @quotes     = @user.quotes
    # @activities = PublicActivity::Activity.all.where(owner: current_user)
    # @template   = "profile"
  end

  def finish_signup
    if request.patch? && params[:user] #&& params[:user][:email]
      if current_user.update(user_params)
        current_user.skip_reconfirmation!
        sign_in(current_user, :bypass => true)
        redirect_to root_path, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
        UserMailer.finish_confirmation(params[:user][:email], current_user).deliver
      end
    end
  end

  def finish_confirmation
    @new_user = User.find_by_email params["email"]
    @user     = User.find_by_id params[:id]
    if @user.destroy
      @auth = @user.authorizations.find_by_provider "twitter"
      @auth.user = @new_user
      @auth.save
      redirect_to root_path, notice: 'Your profile has been donfirmed, please sign in again using your social account'
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :username, :email ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end
