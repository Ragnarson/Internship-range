require 'spec_helper'

feature 'Editing competition' do
  let(:competitor) { create(:competitor) }
  let(:competition) { create(:competition) }
  let(:contest) { create(:contest, competitions: [competition], 
    competitors: [competitor]) }
  let(:shooting) { create(:shooting, competition: competition,
    competitor: competitor) }

  scenario "Changing number of fields" do
    sign_in

    visit edit_contest_competition_path(contest, competition)

    fill_in 'competition_name', with: 'PCP10'
    fill_in 'competition_number_of_shots', with: '3'
    find(:css, ".btn-primary").click

    expect(page).to have_css('.alert-success')
  end
end
