require "spec_helper"

describe "contests/show" do
  context "Contest show view" do
    before(:each) do
      assign(:contest, Contest.create(name: 'Zawody1', date: '2014-09-10'))
      render
    end

    it "displays label 'Nazwa:'" do    
      expect(rendered).to have_selector(
        "p:nth-of-type(1) strong", 
        text: 'Nazwa:'
        )
    end

    it "displays contest name" do
      expect(rendered).to have_selector(                         
          "p:nth-of-type(1)",
          text: 'Zawody1'
          )
    end

    it "displays label 'Data:'" do
      expect(rendered).to have_selector(
        "p:nth-of-type(2) strong",
        text: 'Data:'
        )
    end

    it "displays contest date" do
      expect(rendered).to have_selector(
        "p:nth-of-type(2)",
        text: '2014-09-10'
        )
    end
  end  
end
