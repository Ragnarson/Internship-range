require 'spec_helper'

describe 'sign in page' do
  subject { page }
  before { visit signin_path }

  it 'contains field for email' do
    expect(page).to have_field(
      I18n.t('activerecord.attributes.user.email').capitalize)
  end

  it 'contains field for password' do
    expect(page).to have_field(
      I18n.t('activerecord.attributes.user.password').capitalize)
  end

  it 'flashes error after filled in wrong email' do
    fill_in I18n.t('activerecord.attributes.user.email').capitalize, with: '@example=,com'
    click_button I18n.t('actions.signin')

    expect(page).to have_text(I18n.t('flash.invalid_email_or_password'))
  end

  it 'flashes error after filled in wrong password' do
    fill_in I18n.t('activerecord.attributes.user.password').capitalize, with: ''
    click_button I18n.t('actions.signin')

    expect(page).to have_text(I18n.t('flash.invalid_email_or_password'))
  end
end
