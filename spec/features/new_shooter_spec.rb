require 'spec_helper'

feature 'Shooter' do
  scenario "Create new" do
    sign_in

    visit new_shooter_path

    fill_in I18n.t('activerecord.attributes.shooter.first_name'), 
    with: 'Mietek'
    fill_in I18n.t('activerecord.attributes.shooter.last_name'), 
    with: 'Miet'
    fill_in I18n.t('activerecord.attributes.shooter.date_of_birth'), 
    with: '2014-04-05'
    fill_in I18n.t('activerecord.attributes.shooter.pesel'), 
    with: '11111111111'
    fill_in I18n.t('activerecord.attributes.shooter.joined_date'), 
    with: '2014-04-06'
    fill_in I18n.t('activerecord.attributes.shooter.email'), 
    with: 'example@example.com'
    within_fieldset('first_address') do
      fill_in I18n.t('activerecord.attributes.address.street'), 
      with: 'Krzywa'
      fill_in I18n.t('activerecord.attributes.address.building'), 
      with: '1'
      fill_in I18n.t('activerecord.attributes.address.flat'), 
      with: '1'
      fill_in I18n.t('activerecord.attributes.address.city'), 
      with: 'Mietkowo'
      fill_in I18n.t('activerecord.attributes.address.zip_code'), 
      with: '00-000'
    end

    click_button I18n.t('helpers.submit.shooter.create')

    expect(current_path).to eq '/shooters/1'
    expect(page).to have_content I18n.t('flash.success_create', model: I18n.t('flash.shooter'))

    expect(page).to have_content 'Mietek'
    expect(page).to have_content 'Miet'
  end
end
