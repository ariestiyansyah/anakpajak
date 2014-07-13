class QuestionsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @user     = User.new
    @question = Question.new
  end

  def index
    @questions = Question.all
    @articles = Article.all
  end

  def create
    question      = Question.new set_params
    question.user = current_user
    respond_to do |format|
      if question.save
        #question.create_activity key: 'article.commented_on', owner: current_user
        format.html { redirect_to root_path }
      else
      end
    end
  end

  def set_params
    params.require(:question).permit(:title, :content)           
  end

  def show
    @question     = Question.find_by_id params[:id]
    @answer_new   = Answer.new
    @answers      = @question.answers
  end

  def vote_up
    @question = Question.find_by_id params[:id]
    @question.vote_up current_user
  end
end
