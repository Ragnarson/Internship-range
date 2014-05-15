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
    it "contain first name head" do
      expect(page).to have_selector(
        'th', text: I18n.t('activerecord.attributes.shooter.first_name'))
    end

    it "contain last name head" do
      expect(page).to have_selector(
        'th', text: I18n.t('activerecord.attributes.shooter.last_name'))
    end

    it "contain actions head" do
      expect(page).to have_selector(
        'th', text: I18n.t('actions.actions'))
    end

    it "have links to shooter profile through first name" do
      expect(page).to have_link(shooter.first_name)
    end

    it "have links to shooter profile through last name" do
      expect(page).to have_link(shooter.last_name)
    end

    it "have links to edit user" do
      expect(page).to have_link(I18n.t('actions.edit'))
    end

    it "have links to delete user" do
      expect(page).to have_link(I18n.t('actions.destroy'))
    end
  end
end

