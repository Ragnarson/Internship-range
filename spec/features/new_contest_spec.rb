require 'spec_helper'

feature 'Adding new contest' do
  scenario "adding data" do
    sign_in

    visit new_contest_path

    fill_in 'Nazwa', with: 'strzał'
    fill_in 'Data', with: '2014-04-06'

    click_button 'Utwórz zawody'

    expect(current_path).to eq contests_path
    expect(page).to have_content 'Pomyślnie utworzono zawody'

    expect(page).to have_content '2014-04-06'
    expect(page).to have_content 'strzał'
  end
end
