class HomeController < ApplicationController
  before_action :authenticate_user!
  
  # before_filter :authenticate_user!
  def index
    @questions = Question.all
    render "questions/index"
    # @questions = Question.all.page(params[:page])
    # # debugger
  end
  def timeline
    @activities = PublicActivity::Activity.all  
    @template   = "timeline"
  end
  def login
    @user = User.new
  end
end
