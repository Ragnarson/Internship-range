require 'spec_helper'

feature 'Contest' do
  scenario "Delete contest" do
    sign_in

    visit new_contest_path

    fill_in I18n.t('activerecord.attributes.contest.name'), 
    with: 'strzał1'
    fill_in I18n.t('activerecord.attributes.contest.date'), 
    with: '2014-04-07'

    click_button I18n.t('helpers.submit.create', model: I18n.t('activerecord.models.contest'))

    expect(current_path).to eq contests_path
    expect(page).to have_content I18n.t('flash.success_create', model: I18n.t('activerecord.models.contest'))

    expect(page).to have_content '2014-04-07'
    expect(page).to have_content 'strzał1'

    
    click_link I18n.t('contest.actions.destroy', method: :delete)
    
    expect(current_path).to eq contests_path
    expect(page).to have_content I18n.t('flash.success_destroy', model: I18n.t('activerecord.models.contest'))
  end
end
