class HomeController < ApplicationController
  before_action :authenticate_user!
  before_filter :ensure_signup_complete
  
  def index
    @questions = Question.all.page params[:page]
    render "questions/index"
  end
  
  def timeline
    @activities = PublicActivity::Activity.all.where(owner: current_user)
    @template   = "timeline"
    respond_to do |format|
      format.js
    end
  end
  
  def login
    @user = User.new
  end

end
