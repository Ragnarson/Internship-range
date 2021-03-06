require 'spec_helper'

describe Payment do
  subject(:payment) { build(:payment) }

  it { should respond_to(:description) }
  it { should respond_to(:amount) }
  it { should respond_to(:date) }
  it { should respond_to(:shooter) }

  it { should be_valid }

  context 'when description is not present' do
    before { payment.description = '' }
    it { should_not be_valid }
  end

  context 'when amount is not present' do
    before { payment.amount = '' }
    it { should_not be_valid }
  end

  context 'when amount is smaller than 0' do
    before { payment.amount = '-1' }
    it { should_not be_valid }
  end

  context 'when amount format is invalid' do
    before { payment.amount = 'abcd' }
    it { should_not be_valid }
  end

  context 'when date is not present' do
    before { payment.date = '' }
    it { should_not be_valid }
  end

  context 'when date is not date' do
    before { payment.date = 'aaaa' }
    it { should_not be_valid }
  end

  describe 'by method' do
    context 'when first and last names are exist' do
      before do
        payment.shooter.first_name = 'Adam'
        payment.shooter.last_name = 'Kowalski'
      end

      it { expect(payment.by).to eq('Adam Kowalski') }
    end

    context 'when shooter first and last names are not exists' do
      before do
        payment.shooter.first_name = nil
        payment.shooter.last_name = nil
      end

      it { expect(payment.by).to be_nil }
    end

    context 'when only first name is present' do
      before { payment.shooter.last_name = nil }
      it { expect(payment.by).to be_nil }
    end

    context 'when only last name is present' do
      before { payment.shooter.first_name = nil }
      it { expect(payment.by).to be_nil }
    end
  end

  describe 'Payment.to_csv' do
    let!(:payment) { create(:payment) }

    it 'generates correct csv' do
      expect(Payment.to_csv).to eq("#{I18n.t('payments.payment_date')},"\
        "#{I18n.t('payments.description')},"\
        "#{I18n.t('payments.amount')},"\
        "#{I18n.t('payments.name_of_shooter')}\n2010-01-01,description,1.0,Firstname Lastname\n")
    end
  end
end
