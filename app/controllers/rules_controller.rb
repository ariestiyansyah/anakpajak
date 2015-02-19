class RulesController < ApplicationController
  before_action :authenticate_user!
  before_filter :ensure_signup_complete #, only: [:new, :create, :update, :destroy]
  
  def new
    @rule = Rule.new
  end
  def create
    rule      = Rule.new set_params
    rule.user = current_user
    respond_to do |format|
      if rule.save
        # rule.create_activity key: 'rule.commented_on', owner: current_user
        format.html { redirect_to root_path }
      else
      end
    end
  end

  def set_params
    params.require(:rule).permit(:title, :content)           
  end

  def index
    # data = File.read("#{Rails.root}/public/undang/1.docx")
    # doc       = Docx::Document.open("#{Rails.root}/public/undang/1.docx")
    # @result    = doc.paragraphs.map do |p|
    #   p.to_html
    # end
    yomu = Yomu.new "#{Rails.root}/public/undang/1.docx"
    @result = yomu.html
    # @aji = @result.join("")
    @rules = Rule.all
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @user = User.new
    @rule = Rule.find_by_id params[:id]
    # yomu = Yomu.new "#{Rails.root}/public/undang/1.docx"
    # @result = yomu.html
    @result = File.read ("#{Rails.root}/public/undang/1.htm")
    
  end
  def import
    Rule.import(params[:file])
    redirect_to root_path
  end
  def new_import
    respond_to do |format|
      format.js
    end
  end
end
