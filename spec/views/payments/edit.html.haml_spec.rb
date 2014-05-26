require 'spec_helper'

describe 'payments/edit' do
  let(:payment) { create :payment }
  before do
    sign_in
    visit edit_payment_path(payment)
  end
  %w(shooter-id payment_amount payment_description payment_date).each do |item|
    it "displays inputs for #{item} attribute" do
      @payment = payment
      render
      expect(rendered).to have_selector("input\##{item}")
    end
  end

  context 'editing payment process', type: :feature do
    let(:other_shooter) { create :other_shooter }
    let(:other_payment) { build :other_payment, shooter: other_shooter }

    it 'adds payment' do
      visit edit_payment_path(payment)

      find(:xpath, '//input[@id=\'shooter-id\']').set other_shooter.id
      fill_in 'payment_amount', with: other_payment.amount
      fill_in 'payment_description', with: other_payment.amount

      click_button 'payment_submit'

      expect(page).to have_content I18n.t(
        'flash.success_edit', model: I18n.t('activerecord.models.payment'))
    end
  end
end
