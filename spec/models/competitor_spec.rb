require 'spec_helper'

describe Competitor do
  subject(:competitor) { build(:competitor) }

  context "with attributes present" do
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:date_of_birth) }
    it { should respond_to(:club) }
    it { should respond_to(:pk) }
  end

  context "when first name is not present" do
    before { competitor.first_name = "" }
    it { should_not be_valid }
  end

  context "when last name is not present" do
    before { competitor.last_name = "" }
    it { should_not be_valid }
  end

  context "when date of birth is not present" do
    before { competitor.date_of_birth = "" }
    it { should_not be_valid }
  end

  context "when club name is not present" do
    before { competitor.club = "" }
    it { should_not be_valid }
  end
end
