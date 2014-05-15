require 'spec_helper'

describe "Shooter index" do
  subject { page }
  let!(:shooter) { create(:shooter) }
  before(:each) do
    visit shooters_path
  end

  it "contains a headline" do
    expect(page).to have_selector(
      'h1', text: I18n.t('shooters.list_of_shooters'))
  end

  it "contains a link to add new user" do
    expect(page).to have_link(I18n.t('shooters.new_shooter'), new_shooter_path)
  end

  describe "tables" do
    it "contain names head" do
      expect(page).to have_selector(
        'th', text: I18n.t('shooters.first_name_last_name'))
    end

    it "contain actions head" do
      expect(page).to have_selector(
        'th', text: I18n.t('actions.actions'))
    end

    it "have links to shooter profile" do
      expect(page).to have_link(shooter.full_name)
    end

    it "have links to edit user" do
      expect(page).to have_link(I18n.t('actions.edit'))
    end

    it "have links to delete user" do
      expect(page).to have_link(I18n.t('actions.destroy'))
    end
  end
end

