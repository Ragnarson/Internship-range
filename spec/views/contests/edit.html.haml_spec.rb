require "spec_helper"

describe "contests/edit.html.haml" do
  before do
    assign(:contest, create(:contest))
    render
  end

  it "displays label 'Nazwa:" do
    expect(rendered).to have_selector(
      'label',
      text: 'Nazwa'
      )
  end

  it "displays contest name" do
    expect(rendered).to have_field(
      'Nazwa',
      with: 'Big contest'
      )
  end

  it "displays label 'Data:'" do
    expect(rendered).to have_selector(
      'label',
      text: 'Data'
      )
  end

  it "displays contest date" do
    expect(rendered).to have_field(
      'Data',
      with: '2014-08-26'
      )
  end

  it "has a link to add new competitor" do
    expect(rendered).to have_link("Dodaj zawodnika")
  end

  it "has a button to confirm update" do
    expect(rendered).to have_button("Aktualizuj zawody")
  end
end
