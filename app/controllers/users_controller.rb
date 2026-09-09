class UsersController < ApplicationController
  before_action :authenticate_user!
  def account
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_profile_path, notice: "プロフィール情報が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
