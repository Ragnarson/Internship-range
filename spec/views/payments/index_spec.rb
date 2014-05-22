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
    let!(:payment) { create(:payment) }
    let!(:other_payment) { create(:other_payment) }

    it "has visible search field" do
      expect(page).to have_css('input.form-control')
    end

    it "has visible submit search button" do
      expect(page).to have_css('input.btn.btn-default')
    end

    describe "payments/search page" do
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

    describe "payments/limit_amount" do
      context "no amount is specified" do
        before do
          visit "payments?amount_min=&amount_max="
        end

        it "shows :payment" do
          expect(page).to have_selector('td', text: '2010-01-01')
        end

        it "shows :other_payment" do
          expect(page).to have_selector('td', text: '2011-11-11')
        end
      end

      context "amount_min is given but amount_max is not" do
        context "amount_min is below both payments" do
          before do
            visit "payments?amount_min=0.5&amount_max="
          end

          it "shows :payment" do
            expect(page).to have_selector('td', text: '2010-01-01')
          end

          it "shows :other_payment" do
            expect(page).to have_selector('td', text: '2011-11-11')
          end
        end

        context "amount_min is between two payments" do
          before do
            visit "payments?amount_min=2&amount_max="
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "shows :other_payment" do
            expect(page).to have_selector('td', text: '2011-11-11')
          end
        end

        context "amount_min is over both payments" do
          before do
            visit "payments?amount_min=5&amount_max="
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end
      end

      context "amount_max is given but amount_min is not" do
        context "amount_max is over both payments" do
          before do
            visit "payments?amount_min=&amount_max=5"
          end

          it "shows :payment" do
            expect(page).to have_selector('td', text: '2010-01-01')
          end

          it "shows :other_payment" do
            expect(page).to have_selector('td', text: '2011-11-11')
          end
        end

        context "amount_max is between two payments" do
          before do
            visit "payments?amount_min=&amount_max=2"
          end

          it "shows :payment" do
            expect(page).to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end

        context "amount_max is below both payments" do
          before do
            visit "payments?amount_min=&amount_max=0.5"
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end
      end

      context "both amount_min and amount_max are given" do
        context "both amount_min and amount_max are below payments" do
          before do
            visit "payments?amount_min=0.1&amount_max=0.2"
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end

        context "both amount_min and amount_max are over payments" do
          before do
            visit "payments?amount_min=10&amount_max=10"
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end

        context "both amount_min and amount_max are between payments" do
          before do
            visit "payments?amount_min=2&amount_max=2.2"
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end

        context "amount_min is below :payment and amount_max is between payments" do
          before do
            visit "payments?amount_min=0.1&amount_max=2"
          end

          it "shows :payment" do
            expect(page).to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end

        context "amount_min is between payments and amount_max is over :other_payment" do
          before do
            visit "payments?amount_min=2&amount_max=5"
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "shows :other_payment" do
            expect(page).to have_selector('td', text: '2011-11-11')
          end
        end

        context "payments are between amount_min and amount_max" do
          before do
            visit "payments?amount_min=0.1&amount_max=10"
          end

          it "shows :payment" do
            expect(page).to have_selector('td', text: '2010-01-01')
          end

          it "shows :other_payment" do
            expect(page).to have_selector('td', text: '2011-11-11')
          end
        end
      end
    end

    describe "payments/limit_date" do
      context "no date is specified" do
        before do
          visit "payments?date_min=&date_max="
        end

        it "shows :payment" do
          expect(page).to have_selector('td', text: '2010-01-01')
        end

        it "shows :other_payment" do
          expect(page).to have_selector('td', text: '2011-11-11')
        end
      end

      context "date_min is given but date_max is not" do
        context "date_min is below both payments" do
          before do
            visit "payments?date_min=2009-09-11&date_max="
          end

          it "shows :payment" do
            expect(page).to have_selector('td', text: '2010-01-01')
          end

          it "shows :other_payment" do
            expect(page).to have_selector('td', text: '2011-11-11')
          end
        end

        context "date_min is between two payments" do
          before do
            visit "payments?date_min=2011-10-10&date_max="
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "shows :other_payment" do
            expect(page).to have_selector('td', text: '2011-11-11')
          end
        end

        context "date_min is over both payments" do
          before do
            visit "payments?date_min=2012-01-01&date_max="
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end
      end

      context "date_max is given but date_min is not" do
        context "date_max is over both payments" do
          before do
            visit "payments?date_min=&date_max=2012-12-12"
          end

          it "shows :payment" do
            expect(page).to have_selector('td', text: '2010-01-01')
          end

          it "shows :other_payment" do
            expect(page).to have_selector('td', text: '2011-11-11')
          end
        end

        context "date_max is between two payments" do
          before do
            visit "payments?date_min=&date_max=2011-10-10"
          end

          it "shows :payment" do
            expect(page).to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end

        context "date_max is below both payments" do
          before do
            visit "payments?date_min=&date_max=2009-09-09"
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end
      end

      context "both date_min and date_max are given" do
        context "both date_min and date_max are below payments" do
          before do
            visit "payments?date_min=2008-01-01&date_max=2009-01-01"
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end

        context "both date_min and date_max are over payments" do
          before do
            visit "payments?date_min=2100-01-01&date_max=2200-01-01"
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end

        context "both date_min and date_max are between payments" do
          before do
            visit "payments?date_min=2011-05-05&date_max=2011-05-06"
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end

        context "date_min is below :payment and date_max is between payments" do
          before do
            visit "payments?date_min=2000-01-01&date_max=2011-05-05"
          end

          it "shows :payment" do
            expect(page).to have_selector('td', text: '2010-01-01')
          end

          it "doesn't show :other_payment" do
            expect(page).not_to have_selector('td', text: '2011-11-11')
          end
        end

        context "date_min is between payments and date_max is over :other_payment" do
          before do
            visit "payments?date_min=2011-05-05&date_max=2100-05-05"
          end

          it "doesn't show :payment" do
            expect(page).not_to have_selector('td', text: '2010-01-01')
          end

          it "shows :other_payment" do
            expect(page).to have_selector('td', text: '2011-11-11')
          end
        end

        context "payments are between date_min and date_max" do
          before do
            visit "payments?date_min=2000-01-01&date_max=2100-01-01"
          end

          it "shows :payment" do
            expect(page).to have_selector('td', text: '2010-01-01')
          end

          it "shows :other_payment" do
            expect(page).to have_selector('td', text: '2011-11-11')
          end
        end
      end
    end
  end
end

