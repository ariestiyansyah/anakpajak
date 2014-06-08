class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  def create
    article      = Article.new set_params
    article.user = current_user
    respond_to do |format|
      if article.save
        # article.create_activity key: 'article.commented_on', owner: current_user
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
end
