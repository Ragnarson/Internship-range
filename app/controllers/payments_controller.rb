class PaymentsController < ApplicationController
  def index
    @payments = Payment.all
  end
end
