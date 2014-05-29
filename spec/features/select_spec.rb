require 'spec_helper'

feature 'Contest' do
  let!(:competitor) { create(:competitor) }
  let!(:competition) { create(:competition) }
  let!(:contest) { create(:contest, competitions: [competition], 
    competitors: [competitor]) }

  scenario "Select competitions" do
    sign_in

    visit select_contest_path(contest)
    expect(page).to have_content(competitor.club)
    expect{
      find(:css, ".checkbox").set(true)
      find(:css, ".btn-primary").click
      }.to change(Shooting, :count).by(1)
    expect(page).to have_css('.alert-success')
  end
end
