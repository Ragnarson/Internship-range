require "spec_helper"

describe "payments/index" do
  context "for currency" do
    before do
      sign_in
      create(:payment, amount: 11115343987.32)
      visit 'payments'
    end

    it "displays currency units correctly" do    
      expect(page).to have_selector('td', text: 'zł') 
    end

    it "has proper separators and delimiters" do    
      expect(page).to have_selector('td', text: '11 115 343 987,32') 
    end
  end  
end
