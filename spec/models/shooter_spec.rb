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
  it { should respond_to(:email) }
  it { should respond_to(:active) }

  it { should be_valid }

  context "when first name is not present" do
    before { shooter.first_name = "" }
    it { should_not be_valid }
  end

  context "when last name is not present" do
    before { shooter.last_name = "" }
    it { should_not be_valid }
  end

  context "when date of birth is not present" do
    before { shooter.date_of_birth = "" }
    it { should_not be_valid }
  end

  context "when pesel is not present" do
    before { shooter.pesel = "" }
    it { should_not be_valid }
  end

  context "when pesel is too short" do
    before { shooter.pesel = "1" }
    it { should_not be_valid }
  end

  context "when pesel is too long" do
    before { shooter.pesel = "1"*12 }
    it { should_not be_valid }
  end

  context "when pesel format is invalid" do
    before { shooter.pesel = "abcd" }
    it { should_not be_valid }
  end

  context "when pesel is already taken" do
    let!(:shooter_with_same_pesel) { create(:shooter, pesel: shooter.pesel) }
    it { should_not be_valid }
  end

  context "when joined date is not present" do
    before { shooter.joined_date = "" }
    it { should_not be_valid  }
  end

  context "when joined date is not date" do
    before { shooter.joined_date = "london" }
    it { should_not be_valid }
  end

  context "when email format is invalid" do
    it "should be invalid" do
      adresses = %w[user@foo,com
        user_at_foo.org
        example.user@foo. foo@bar_baz.com
        foo@bar+baz.com
        foobar@exam..ple.com]
      adresses.each do |invalid_adress|
        shooter.email = invalid_adress
        expect(shooter).not_to be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      adresses = %w[user@foo.COM A_US-ER@f.b.org
        first.last@foo.jp a+b@baz.cn]
      adresses.each do |valid_adress|
        shooter.email = valid_adress
        expect(shooter).to be_valid
      end
    end
  end

  context "when email adress is already taken" do
    let!(:shooter_with_same_email) { create(:shooter, email: shooter.email) }
    it { should_not be_valid }
  end

  describe "when has not any addresses" do
    before { shooter.addresses.destroy_all }
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

  describe 'update_weapon_list method' do
    context 'shooter @sport_permission == false' do
      before do
        shooter.update_attributes(handgun: true,
          rifle: true,
          shotgun: true,
          sport_permission: false)
        shooter.reload 
      end
      it { expect(shooter.handgun).to be(nil) }
      it { expect(shooter.rifle).to be(nil) }
      it { expect(shooter.shotgun).to be(nil) }
    end
  end
end
