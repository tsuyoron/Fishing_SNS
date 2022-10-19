class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path(current_user.id), notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :introduction)
  end
end
