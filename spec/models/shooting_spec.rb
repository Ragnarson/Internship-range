require 'spec_helper'

describe Shooting do
  subject(:shooting) { create(:shooting) }

  before(:each) { shooting.explode_target }

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

  describe '#explode_target' do
    it { should respond_to(:shot_0) }
    it { should respond_to(:shot_4) }
  end

  describe '#wipe_virtual_attributes' do
    before { shooting.send(:wipe_virtual_attributes) }

    it 'clears the virtual_attributes' do
      expect(shooting).to_not respond_to(:shot_0)
      expect(shooting).to_not respond_to(:shot_4)
    end
  end

  describe '#virtual_attributes' do
    it 'matches the number of target values' do
      expect(shooting.send(:virtual_attributes).count).to eq shooting.target.length
    end
  end
end
