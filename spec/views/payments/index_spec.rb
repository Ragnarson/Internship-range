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

  describe '.search' do
    it "has visible search field" do
      expect(page).to have_css('input.form-control')
    end

    it "has visible submit search button" do
      expect(page).to have_css('input.btn.btn-default')
    end

    describe "payments/search page" do
      let!(:payment) { create(:payment) }
      let!(:other_payment) { create(:other_payment) }
      before do
        visit "payments?search=OTHER"
      end

      it "has case insensitive search" do
        expect(page).to have_selector('td', text: "other")
      end

      it "shows correctly :other_payment mathing 'OTHER'" do
        expect(page).to have_selector('td', text: "2011-11-11")
      end

      it "doesn't show user that do not match to 'THIRD'" do
        expect(page).not_to have_selector('td', text: "2010-01-01")
      end
    end
  end
end

