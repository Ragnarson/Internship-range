require 'spec_helper'

feature 'Editing contest' do
  given!(:contest) { create(:contest) }
  background do
    sign_in
    visit edit_contest_path(contest)
  end

  scenario "changing data" do
    fill_in 'Data', with: '2020-06-06'
    fill_in 'Nazwa', with: 'Future shots'

    click_button I18n.t('helpers.submit.update', model: I18n.t('activerecord.models.contest'))

    expect(current_path).to eq contest_path(contest)
    expect(page).to have_content I18n.t('flash.success_edit', model: I18n.t('activerecord.models.contest'))

    expect(page).to have_content '2020-06-06'
    expect(page).to have_content 'Future shots'
  end

  scenario "click add new competitor link", js: true do
    click_link I18n.t(:add_competitor, scope: :contest)
    expect(page).to have_selector('.form-group .col-xs-2 .control-label',
      text: I18n.t('activerecord.attributes.contest.first_name'))
    within '.competitor-form' do
      fill_in I18n.t('activerecord.attributes.contest.first_name'), with: 'Goku'
      fill_in I18n.t('activerecord.attributes.contest.last_name'), with: 'Son'
    end
  end
end
