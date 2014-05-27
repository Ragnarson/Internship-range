class UsersController < ApplicationController
  before_action :user, only: [:edit, :destroy, :update]

  def index
    @users = User.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path,
        notice: I18n.t('flash.success_create', model: I18n.t('user.user'))
    else
        render action: 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path,
        notice: I18n.t('flash.success_edit', model: I18n.t('user.user'))
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path,
      notice: I18n.t('flash.success_destroy', model: I18n.t('user.user'))
  end

  private
  def user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
