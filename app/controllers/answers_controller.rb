class AnswersController < ApplicationController
  def create
    @question         = Question.find_by_id params[:question_id]
    @answer           = Answer.new
    @answer.user      = current_user
    @answer.question  = @question
    @answer.content   = params[:answer][:content]
    @answer.save
  end
end
