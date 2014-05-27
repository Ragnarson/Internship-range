require "spec_helper"

describe Judge do  
  subject(:judge) { build(:judge) }

    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:function) }
    it { should respond_to(:license_number) }
     
    describe "when first name is not present" do
      before { judge.first_name = "" }
      it { should_not be_valid }
    end
    
    describe "when last name is not present" do
      before { judge.last_name = "" }
      it { should_not be_valid }
    end
    
    describe "when function is not present" do
      before { judge.function = "" }
      it { should_not be_valid }
    end
    
    describe "when license_number is not present" do
      before { judge.license_number = "" }
      it { should_not be_valid }
    end
  end
