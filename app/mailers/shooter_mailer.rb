class ShooterMailer < ActionMailer::Base
  default :from => "noreply@bazuka.com"

  def payment(payment)
    @shooter = payment.shooter
    @payment = payment
    mail(:to => @shooter.email, :subject => I18n.t('payments.notification'))
  end
end

