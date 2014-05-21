class SessionsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]

  def new
    render layout: 'signin'
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = t('flash.logged_in')
      redirect_to root_url
    else
      flash.now[:alert] = t('flash.invalid_email_or_password')
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = t('flash.logged_out')
    redirect_to signin_path
  end
end
