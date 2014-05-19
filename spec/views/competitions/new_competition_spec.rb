require "spec_helper"

describe "View of new competition" do
  subject { page }
  let!(:contest) { create(:contest) }
  before(:each) do
    sign_in
    visit new_contest_competition_path(contest)
  end

  it "contains a headline" do
    expect(page).to have_selector(
      'h2', text: I18n.t('activerecord.models.competition.one').capitalize)
  end

  describe "labels" do
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

