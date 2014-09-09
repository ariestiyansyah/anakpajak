class HomeController < ApplicationController
  before_action :authenticate_user!
  before_filter :ensure_signup_complete #, only: [:new, :create, :update, :destroy]
  
  # before_filter :authenticate_user!
  def index
    @questions = Question.all.page params[:page]
    render "questions/index"
    # @questions = Question.all.page(params[:page])
  end
  def timeline
    @activities = PublicActivity::Activity.all.where(owner: current_user)
    # debugger
    @template   = "timeline"
  end
  def login
    @user = User.new
  end
end
