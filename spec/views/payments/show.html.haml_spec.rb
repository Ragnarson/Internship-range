require 'spec_helper'

describe "payments/show" do
  before do
    payment = create(:payment,
      description: 'oplata 2014',
      amount: 40.00,
      date: '2012-12-12',
      shooter: create(:shooter, first_name: 'Janek', last_name: 'Kowalski'))
    visit payment_path payment
   end

  it "displays the payer's name correctly" do
    expect(page).to have_selector('p', text: 'Janek')
  end

  it "displays the payer's last name correctly" do
    expect(page).to have_selector('p', 'Kowalski')
  end

  it "displays the payment's description correctly" do
    expect(page).to have_selector('p', 'oplata 2014')
  end

  it "displays the payment's amount correctly" do
    expect(page).to have_selector('p', '40 zł')
  end

  it "displays the payment's date correctly" do
    expect(page).to have_selector('p', '2012-12-12')
  end
end
