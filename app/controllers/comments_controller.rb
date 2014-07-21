class CommentsController < ApplicationController
  def index
    
  end

  def create
    @article          = Article.find_by_id params[:article_id]
    @comment          = @article.comments.create
    @comment.user     = current_user
    @comment.comment  = params[:comment][:comment]
    @comment.save
    @comments = @article.comments
  end

  def update
    
  end
  def new
    article   = Article.find_by_id params[:article_id]
    @comment  = article.comments.new
  end
end
