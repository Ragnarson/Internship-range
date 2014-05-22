class PaymentsController < ApplicationController
  before_action :payment, only: [:edit, :update, :destroy, :notify]
  helper_method :sort_direction, :sort_column

  def index
    @payments = Payment.limit_amount(params[:amount_min], params[:amount_max]).
      limit_date(params[:date_min], params[:date_max]).
      search(params[:search]).
      order(sort_column + " " + sort_direction).
      page(params[:page])
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

  def notify
    ShooterMailer.delay(queue: 'payments', priority: 20,
      run_at: 15.seconds.from_now).payment(payment)
    redirect_to payments_path,
      notice: I18n.t('payments.delivery')
  end

  private
  def payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:description, :amount, :date,
      :shooter_id, :expiry_date)
  end

  def sort_column
    Payment.column_names.include?(params[:sort]) ? params[:sort] : "date"
  end

  def sort_direction
    ["asc", "desc"].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
