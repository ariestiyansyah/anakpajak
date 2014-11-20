class ConsultantsController < ApplicationController
  before_action :authenticate_user!
  before_filter :ensure_signup_complete #, only: [:new, :create, :update, :destroy]
  
  def index
    @jumlah       = Consultant.count 
    @consultants  = Consultant.page(params[:page]).per 10
    respond_to do |format|
      format.js
    end
  end
  def import
    Consultant.import(params[:file])
    redirect_to root_path
  end
  def new_import
  end
end
