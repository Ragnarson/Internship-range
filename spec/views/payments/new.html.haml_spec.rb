require 'spec_helper'

describe 'payments/new' do
  let(:payment) { build :payment, shooter: nil }
  before do
    sign_in
    visit new_payment_path
  end
  %w(shooter-id payment_amount payment_description payment_date).each do |item|
    it "displays input field for #{item} attribute" do
      @payment = payment
      render
      expect(rendered).to have_selector("input\##{item}")
    end
  end

  context 'adding payment process', type: :feature do
    let(:shooter) { create :shooter }

    it 'adds payment' do
      visit new_payment_path

      find(:xpath, '//input[@id=\'shooter-id\']').set shooter.id
      fill_in 'payment_amount', with: payment.amount
      fill_in 'payment_description', with: payment.amount
      fill_in 'payment_date', with: payment.date

      click_button 'payment_submit'

      expect(page).to have_content I18n.t(
        'flash.success_create', model: I18n.t('activerecord.models.payment'))
    end
  end
end
