class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_filter :ensure_signup_complete #, only: [:new, :create, :update, :destroy]
  
  
  def create
    @question         = Question.find_by_id params[:question_id]
    @answer           = Answer.new
    @answer.user      = current_user
    @answer.question  = @question
    @answer.content   = params[:answer][:content]
    @answer.save
  end
end
