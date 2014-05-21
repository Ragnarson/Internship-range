require 'spec_helper'

feature 'Contest' do
  scenario "Create new" do
    sign_in

    visit new_contest_path

    fill_in I18n.t('activerecord.attributes.contest.name'), 
    with: 'strzał'
    fill_in I18n.t('activerecord.attributes.contest.date'), 
    with: '2014-04-06'

    click_button I18n.t('helpers.submit.create', model: I18n.t('activerecord.models.contest'))

    expect(current_path).to eq contests_path
    expect(page).to have_content I18n.t('flash.success_create', model: I18n.t('activerecord.models.contest'))

    expect(page).to have_content '2014-04-06'
    expect(page).to have_content 'strzał'
  end
end
