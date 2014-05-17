require 'spec_helper'

feature 'Editing contest' do
  scenario "changing data" do
    sign_in

    contest = create(:contest)

    visit edit_contest_path(contest)

    fill_in 'Data', with: '2020-06-06'
    fill_in 'Nazwa', with: 'Future shots'

    click_button 'Aktualizuj zawody'

    expect(current_path).to eq contest_path(contest)
    expect(page).to have_content 'Pomyślnie zaktualizowano zawody'

    expect(page).to have_content '2020-06-06'
    expect(page).to have_content 'Future shots'
  end
end
