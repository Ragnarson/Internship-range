require 'spec_helper'

describe ShooterMailer do
  describe 'payment method' do
    let(:shooter) { create :shooter}
    let(:resource) { create :payment, shooter: shooter }
    let(:mail) { ShooterMailer.payment(resource) }

    it 'renders the subject' do
      expect(mail.subject). to eq(I18n.t('payments.notification'))
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([shooter.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['noreply@bazuka.com'])
    end

    it 'assigns shooter name' do
      expect(mail.body.encoded).to include(shooter.first_name)
    end

    it 'assigns expiry_date' do
      expect(mail.body.encoded).to include(resource.expiry_date.to_s)
    end

    it 'assigns expire_at translation' do
      expect(mail.body.encoded).to include(I18n.t('payments.expire_at'))
    end

    it 'assigns remember translation' do
      expect(mail.body.encoded).to include(I18n.t('payments.remember'))
    end
  end
end

