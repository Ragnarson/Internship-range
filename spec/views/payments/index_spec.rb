require "spec_helper"

describe 'payments/index' do
  subject { page }
  let!(:shooter) { create(:shooter) }
  let!(:resource) { create(:other_payment, shooter: shooter) }
  let(:send_notification) { -> { click_link I18n.t('payments.send') } }
  before(:each) do
    sign_in
    visit payments_path
  end

  context 'for currency' do
    it 'displays currency units correctly' do
      expect(page).to have_selector('td', text: 'zł')
    end

    it 'has proper separators and delimiters' do
      expect(page).to have_selector('td', resource.amount)
    end
  end

  context 'contains link to shooter profile' do
    it { expect(page).to have_link(resource.by) }
  end

  context 'contains link to payment' do
    it { expect(page).to have_link(resource.description) }
  end

  context 'contains link to edit payment' do
    it { expect(page).to have_link(I18n.t('actions.edit')) }
  end

  context 'contains link to destroy payment' do
    it { expect(page).to have_link(I18n.t('actions.destroy')) }
  end

  context 'if expired? is true' do
    it 'contains link to send notification' do
      expect(page).to have_link(I18n.t('payments.send'))
    end

    it 'admin can send notification to shooter' do
      expect(send_notification).to change(Delayed::Job, :count).by(1)
    end
  end
end

