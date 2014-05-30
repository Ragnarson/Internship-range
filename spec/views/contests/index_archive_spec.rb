require 'spec_helper'

describe "Contest index archive" do
  let!(:other_contest) { create(:other_contest) }
  before(:each) do
    sign_in
    visit contests_archive_url
  end

  it "contains a headline" do
    expect(page).to have_selector(
      'h2', text: I18n.t('contest.archive'))
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

    it "has link to contest profile through name" do
      expect(page).to have_link(other_contest.name)
    end

    it "has link to future contests" do
      expect(page).to have_link(I18n.t('contest.future').capitalize)
    end
 end

  describe ".search" do
    let!(:new_contest) { create(:contest, date: "2014-03-03") }

    it "has visible search field" do
      expect(page).to have_css('input.form-control')
    end

    it "has visible submit search button" do
      expect(page).to have_css('input.btn.btn-default')
    end

    describe "contests_archive/search page" do
      before do
        visit "contests_archive?search=#{other_contest.name.upcase}"
      end

      it "has case insensitive search" do
        expect(page).to have_selector('td', text: "#{other_contest.name}")
      end

      it "shows correct contest" do
        expect(page).to have_selector('td', text: "#{other_contest.date}")
      end

      it "doesn't show contests that do not match" do
        expect(page).not_to have_selector('td', text: "#{new_contest.date}")
      end
    end
  end
end
