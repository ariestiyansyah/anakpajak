class UsersController < ApplicationController
  def timeline
  end
  def profile
    @user = User.find_by_username params[:username]
  end
end
