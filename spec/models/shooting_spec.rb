require 'spec_helper'

describe Shooting do
  subject(:shooting) { create(:shooting) }

  before(:each) { shooting.send(:explode_target) }

  context 'when all attributes are present' do
    it { should respond_to(:target) }
    it { should respond_to(:competition) }
    it { should respond_to(:competitor) }
    it { should be_valid }
  end

  context 'when competitor id is not present' do
    before { shooting.competitor_id = nil }
    it { should_not be_valid }
  end

  context 'when competition id is not present' do
    before { shooting.competition_id = nil }
    it { should_not be_valid }
  end

  describe '#number_of_fields' do
    context 'when the value is nil' do
      let(:shooting) { create(:shooting) }
      before { shooting.stub(:number_of_fields) }

      it 'returns nil' do
        expect(shooting.number_of_fields).to be(nil)
      end

      it 'should not raise errors' do
        expect { shooting }.not_to raise_error
      end
    end
  end

  describe '#explode_target' do
    it 'responds_to virtual_attributes' do
      expect(shooting).to respond_to(:shot_0, :shot_4)
    end
  end

  describe '#remove_virtual_attributes' do
    before { shooting.send(:remove_virtual_attributes) }
    it 'clears the virtual_attributes' do
      expect(shooting).to_not respond_to(:shot_0, :shot_4)
    end
  end

  describe '#virtual_attributes' do 
    it 'matches the number of target values' do
      expect(shooting.virtual_attributes.count).to eq shooting.target.length
    end
  end
end
