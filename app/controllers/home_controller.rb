class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    @user = User.new
    @questions = Question.all.page(params[:page])
    # debugger
  end
  def timeline
    
  end
end
