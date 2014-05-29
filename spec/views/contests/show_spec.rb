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
        text: contest.name
      )
    end

    it "displays contest date" do
      expect(page).to have_selector(
        "h4:nth-of-type(1)",
        text: '2014-08-26'
      )
    end
  end

  context "for contest judges" do
    it "displays judges heading" do
      expect(page).to have_content t('activerecord.models.judge.other')
    end

    it "displays judges first name" do
      expect(page).to have_content t('activerecord.attributes.shooter.last_name')
    end

    it "displays judges last name" do
      expect(page).to have_content t('activerecord.attributes.shooter.last_name')
    end

    it "displays judges function" do
      expect(page).to have_content t('activerecord.attributes.contest.function')
    end

    it "displays judges license number" do
      expect(page).to have_content t('activerecord.attributes.contest.license_number')
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
          "tbody tr:nth-of-type(1) td:nth-of-type(1)", text: competition1.name
        )
      end

      it "classification" do
        expect(page).to have_selector(
          "tbody tr:nth-of-type(1) td:nth-of-type(2)", text: competition1.classification
        )
      end

      it "number of competitors" do
        expect(page).to have_selector(
          "tbody tr:nth-of-type(1) td:nth-of-type(3)", text:'0'
        )
      end

      it "number of shots" do
        expect(page).to have_selector(
          "tbody tr:nth-of-type(1) td:nth-of-type(4)", text:'10'
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

  context "new competition form" do
    it "contains a headline" do
      expect(page).to have_selector(
        'h2', text: I18n.t('activerecord.models.competition.one').capitalize)
    end

    it "have field for comeptition name" do
      expect(page).to have_field(
        I18n.t('activerecord.attributes.competition.name'))
    end

    it "have field for classification" do
      expect(page).to have_field(
        I18n.t('activerecord.attributes.competition.classification'))
    end

    it "have field for number of shots" do
      expect(page).to have_field(
        I18n.t('activerecord.attributes.competition.number_of_shots'))
    end
  end
end
