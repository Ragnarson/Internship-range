require "spec_helper"

describe "payments/show" do
  context "for currency" do
    before do
      payment = create(:payment, amount: 2343987.12)
      visit payment_path payment
    end

    it "displays currency units correctly" do    
      expect(page).to have_selector('p', text: 'zł') 
    end

    it "has proper separators and delimiters" do    
      expect(page).to have_selector('p', text: '2 343 987,12') 
    end
  end  
end
