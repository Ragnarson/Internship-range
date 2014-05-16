require 'spec_helper'

describe Contest do
  subject(:contest) { build(:contest) }

  context "with attributes present" do
    it { should respond_to(:name) }
    it { should respond_to(:date) }
    it { should be_valid }
  end

  context "when name is not present" do
    before { contest.name = "" }
    it { should_not be_valid }
  end

  context "when date is not present" do
    before { contest.date = "" }
    it { should_not be_valid }
  end
end
