require 'spec_helper'

describe Payment do
  subject(:payment) { build(:payment) }

  it { should respond_to(:description) }
  it { should respond_to(:amount) }
  it { should respond_to(:date) }
  it { should respond_to(:expiry_date) }
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

  context 'when expiry date is not present' do
    before { payment.expiry_date = '' }
    it { should_not be_valid }
  end

  context 'when expiry date is not a date' do
    before { payment.expiry_date = 'bbbb' }
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

  describe 'expired? method' do
    let(:shooter) { build(:shooter) }
    let(:expired_payment) { build(:other_payment, shooter: shooter) }
    let(:valid_payment) { build(:payment, shooter: shooter) }

    context 'when expiry_date is less than 7 days' do
      it { expect(expired_payment.expired?).to be true }
    end

    context 'when expiry_date is more than 7 days' do
      it { expect(valid_payment.expired?).to be false }
    end
  end
end

