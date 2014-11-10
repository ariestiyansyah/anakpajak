class ConsultantsController < ApplicationController
  before_action :authenticate_user!
  before_filter :ensure_signup_complete #, only: [:new, :create, :update, :destroy]
  
  def index
    respond_to do |format|
      format.js
    end
  end
end
