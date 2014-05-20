class PaymentsController < ApplicationController
  before_action :payment, only: [:edit, :update, :destroy]

  def index
    @payments = Payment.all
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def new
    @payment = Payment.new
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to payments_path,
        notice: I18n.t(
          'flash.success_create',
           model: I18n.t('activerecord.models.payment'))
    else
      render :new
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to @payment,
        notice: I18n.t(
          'flash.success_edit',
          model: I18n.t('activerecord.models.payment'))
    else
      render :edit
    end
  end

  def destroy
    @payment.destroy
    redirect_to payments_url,
      notice: I18n.t(
        'flash.success_destroy',
        model: I18n.t('activerecord.models.payment'))
  end

  private
  def payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:description, :amount, :date,
      :shooter_id, :expiry_date)
  end
end
