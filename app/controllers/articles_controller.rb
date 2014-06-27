class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  def create
    article      = Article.new set_params
    article.user = current_user
    respond_to do |format|
      if article.save
        article.create_activity key: 'article.create', owner: current_user
        format.html { redirect_to root_path }
      else
      end
    end
  end

  def set_params
    params.require(:article).permit(:title, :content)           
  end

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find_by_id params[:id]
    respond_to do |format|
      format.html #render show.html.erb
      # format.json { render json: @article }
      # format.js { render json: @article, callback: params[:callback] }
    end
  end
end
