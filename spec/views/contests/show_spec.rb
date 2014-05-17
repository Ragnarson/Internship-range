require "spec_helper"

describe "contests/show" do
  subject { page }
  let(:contest) { create(:contest) }
  let!(:competition1) { create(:competition, contest: contest) }
  let!(:competition2) { create(:other_competition, contest: contest) }
  before do
    sign_in
    visit contest_path(contest)
  end

  context "for contest info" do
    it "displays contest name" do
      expect(page).to have_selector(
        "h1:nth-of-type(1) strong",
        text: 'Big contest'
      )
    end

    it "displays contest date" do
      expect(page).to have_selector(
        "h4:nth-of-type(1)",
        text: '2014-08-26'
      )
    end
  end

  context "for competitions list" do
    it "displays all competitions" do
      expect(page).to have_css(
        "tbody tr", count: 2
      )
    end

    context "competition table displays" do
      it "name" do
        expect(page).to have_selector(
          "tbody tr:nth-of-type(1) td:nth-of-type(1)", text:'Shooting stars'
        )
      end

      it "classification" do
        expect(page).to have_selector(
          "tbody tr:nth-of-type(1) td:nth-of-type(2)", text:'PSP 10'
        )
      end

      it "number of shots" do
        expect(page).to have_selector(
          "tbody tr:nth-of-type(1) td:nth-of-type(3)", text:'10'
        )
      end

      it "button to edit competition" do
        expect(page).to have_link(
          I18n.t('actions.edit'),
          edit_contest_competition_path(contest, competition1)
        )
      end

      it "button to delete competition" do
        expect(page).to have_link(
          I18n.t('actions.destroy'),
          contest_competition_path(contest, competition1)
        )
      end
    end
  end

  it "displays link to add new competition page" do
    expect(page).to have_link(
      I18n.t('competitions.new_competition'), new_contest_competition_path(contest))
  end
end
