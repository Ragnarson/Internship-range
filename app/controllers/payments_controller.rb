class PaymentsController < ApplicationController
  before_action :payment, only: [:edit, :update]

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
      redirect_to payments_path,
      notice: I18n.t(
        'flash.success_edit',
        model: I18n.t('activerecord.models.payment'))
    else
      render :edit
    end
  end

  private
  def payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:description, :amount, :date, :shooter_id)
  end
end
