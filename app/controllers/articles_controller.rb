class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_filter :ensure_signup_complete #, only: [:new, :create, :update, :destroy]
  
  def new
    @article = Article.new
  end
  def create
    @article      = Article.new set_params
    @article.user = current_user
    respond_to do |format|
      if @article.save
        WebsocketRails[:articles].trigger 'new', @article
        @article.create_activity key: 'article.create', owner: current_user, recipient: @article
        format.html { redirect_to root_path }
      else
      end
    end
  end

  def set_params
    params.require(:article).permit(:title, :content, :bootsy_image_gallery_id)           
  end

  def index
    @articles  = Article.page(params[:page]).per 10
    respond_to do |format|
      format.js
    end
  end

  def show
    @article  = Article.find_by_id params[:id]
    @comment  = Comment.new
    @comments = @article.comments
  end
end
