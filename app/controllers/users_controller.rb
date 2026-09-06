class UsersController < ApplicationController
  def account
    @user = current_user
  end

  def profile
    @user = current_user
  end
end
