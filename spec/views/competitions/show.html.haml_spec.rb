require "spec_helper"

describe "competitions/show" do
  let!(:contest) { create(:contest, id: 1, name: 'contest', date: '2020-04-20') }
  let!(:competition) { create(:competition, id: 1, contest_id: 1,
    classification: 'psp10', number_of_shots: 3, name: 'competition')
  }
  let!(:competitor) { create(:competitor, id: 1, contest_id: 1, first_name: 'Majk', last_name: 'Tajson',
    date_of_birth: '2010-10-10',club: 'Topgun', pk: false)
  }
  let!(:shooting) { Shooting.new(id: 1, competitor_id: 1, competition_id: 1, target: ["1", "1", "1"]) }

  before(:each) do
    sign_in
    visit contest_competition_path(contest, competition)
  end

  context "for competition's details" do
    it "displays the competition's name correctly" do
      expect(page).to have_selector('td', text: competition.name)
    end

    it "displays the competition's classification correctly" do
      expect(page).to have_selector('td', text: competition.classification)
    end

    it "displays the competition's number of shots correctly" do
      expect(page).to have_selector('td', competition.number_of_shots)
    end
  end

  context "for competitors results" do
    it "displays the label first name correctly" do
      expect(page).to have_selector('th', text: I18n.t('competitions.competitor_first_name'))
    end

    it "displays the label last name correctly" do
      expect(page).to have_selector('th', text: I18n.t('competitions.competitor_last_name'))
    end

    it "displays the label earned points correctly" do
     expect(page).to have_selector('th', text: I18n.t('competitions.earned_points'))
    end

    it "displays label earned points sum correctly" do
      expect(page).to have_selector('th', text: I18n.t('competitions.earned_points_sum'))
    end
  end
end
