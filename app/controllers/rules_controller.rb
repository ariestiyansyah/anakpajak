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
    @rules = Rule.all
  end

  def show
    @rule = Rule.find_by_id params[:id]
  end
end
