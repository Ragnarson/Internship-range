require 'spec_helper'

describe "Shooter index" do
  subject { page }
  let!(:contest) { create(:contest) }
  before(:each) do
    sign_in
    visit contests_path
  end

  it "contains a headline" do
    expect(page).to have_selector(
      'h2', text: I18n.t('activerecord.models.contest').capitalize)
  end

  describe "tables" do
    it "contains name header" do
      expect(page).to have_selector(
        'th', text: I18n.t('activerecord.attributes.contest.name'))
    end

    it "contains date header" do
      expect(page).to have_selector(
        'th', text: I18n.t('activerecord.attributes.contest.date'))
    end

    it "contains shooters head" do
      expect(page).to have_selector('th', text: I18n.t('mainmenu.shooters'))
    end

    it "contains competitions head" do
      expect(page).to have_selector('th', text: I18n.t('mainmenu.competitions'))
    end

    it "contains actions head" do
      expect(page).to have_selector(
        'th', text: I18n.t('actions.actions'))
    end

    it "has link to contest profile through name" do
      expect(page).to have_link(contest.name)
    end

    it "has links to edit contests" do
      expect(page).to have_link(I18n.t('actions.edit'))
    end

    it "has links to delete contests" do
      expect(page).to have_link(I18n.t('actions.destroy'))
    end

    it "has link to contests archive" do
      expect(page).to have_link(I18n.t('contest.archive'))
    end

    it "has centered buttons" do
      expect(page).to have_css('td.text-center')
    end
  end

  describe ".search" do
    it "has visible search field" do
      expect(page).to have_css('input.form-control')
    end

    it "has visible submit search button" do
      expect(page).to have_css('input.btn.btn-default')
    end

    describe "contests/search page" do
      let!(:contest) { create(:contest) }
      let!(:other_contest) { create(:other_contest)}

      before do
        visit "contests?search=#{contest.name.downcase}"
      end

      it "has case insensitive search" do
        expect(page).to have_selector('td', text: "#{contest.name}")
      end

      it "shows correctly :contest matching 'ZAWODY'" do
        expect(page).to have_selector('td', text: "#{contest.date}")
      end

      it "doesn't show contests that do not match to 'ZAWODY'" do
        expect(page).not_to have_selector('td', text: "2014-01-03")
      end
    end
  end
end
