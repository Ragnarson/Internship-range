require 'spec_helper'

describe Shooter do
  subject(:shooter) { build(:shooter) }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:date_of_birth) }
  it { should respond_to(:pesel) }
  it { should respond_to(:joined_date) }
  it { should respond_to(:payments) }
  it { should respond_to(:addresses) }
  it { should respond_to(:contests) }
  it { should respond_to(:competitions) }

  it { should be_valid }

  describe "when first name is not present" do
    before { shooter.first_name = "" }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
    before { shooter.last_name = "" }
    it { should_not be_valid }
  end

  describe "when date of birth is not present" do
    before { shooter.date_of_birth = "" }
    it { should_not be_valid }
  end

  describe "when pesel is not present" do
    before { shooter.pesel = "" }
    it { should_not be_valid }
  end

  describe "when pesel is too short" do
    before { shooter.pesel = "1" }
    it { should_not be_valid }
  end

  describe "when pesel is too long" do
    before { shooter.pesel = "1"*12 }
    it { should_not be_valid }
  end

  describe "when pesel format is invalid" do
    before { shooter.pesel = "abcd" }
    it { should_not be_valid }
  end

  describe "when pesel is already taken" do
    before do
      shooter_with_same_pesel = shooter.dup
      shooter_with_same_pesel.save
    end

    it { should_not be_valid }
  end

  describe "when joined date is not present" do
    before { shooter.joined_date = "" }
    it { should_not be_valid  }
  end

  describe "when joined date is not date" do
    before { shooter.joined_date = "london" }
    it { should_not be_valid }
  end

  describe "full_name method" do
    context "when first and last names are exist" do
      before do
        shooter.first_name = "Adam"
        shooter.last_name = "Kowalski"
      end

      it { expect(shooter.full_name).to eq("Adam Kowalski") }
    end

    context "when shooter first and last names are not exists" do
      before do
        shooter.first_name = nil
        shooter.last_name = nil
      end

      it { expect(shooter.full_name).to be_nil }
    end

    context "when only first name is present" do
      before { shooter.last_name = nil }
      it { expect(shooter.full_name).to be_nil }
    end

    context "when only last name is present" do
      before { shooter.first_name = nil }
      it { expect(shooter.full_name).to be_nil }
    end
  end
end

