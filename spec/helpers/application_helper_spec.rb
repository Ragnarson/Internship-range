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

  context "display_for_visible method" do
    it 'returns value when attribute is present' do
      expect(display_for_visible('value', '-')).to eq('value')
    end
    context 'when attribute is blank' do
      it 'returns placeholder if it is specified' do
        expect(display_for_visible([], '&')).to eq('&')
      end
      it 'returns dash if placeholder is not specified' do
        expect(display_for_visible([])).to eq('-')
      end
    end
  end
end
