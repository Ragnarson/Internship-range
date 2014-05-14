require 'spec_helper'

describe ApplicationHelper do
  context "change_to_currency method" do
    it "has format: \":number :unit\"" do
      expect(change_to_currency(123)).to eq("123 zł")
    end

    it "delimits correctly with \" \"" do
      expect(change_to_currency(20000)).to eq("20 000 zł")
    end

    it "separates correctly with \",\"" do
      expect(change_to_currency(5.5)).to eq("5,5 zł")
    end
  end
end
