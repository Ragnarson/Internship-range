require 'spec_helper'

describe Address do
  subject(:address) { create(:address) }

  it { should respond_to(:city) }
  it { should respond_to(:building) }
  it { should respond_to(:zip_code) }
  it { should respond_to(:street) }
  it { should respond_to(:flat) }
  it { should be_valid }

  context 'without building' do
    before { address.building = nil }
    it { should_not be_valid }
  end

  context 'without city' do
    before { address.city = nil }
    it { should_not be_valid }
  end

  context 'without zip_code' do
    before { address.zip_code = nil }
    it { should_not be_valid }
  end

  describe '#is_first?' do
    let(:shooter) { create(:shooter) }
    before { shooter.addresses.create(attributes_for(:other_address)) }

    context 'if address is first for user' do
      it 'returns true' do
        expect(shooter.addresses.first.is_first?).to be(true)
      end
    end

    context 'if address is not first for user' do
      it 'returns false' do
        expect( shooter.addresses.last.is_first?).to be(false)
      end
    end
  end
end
