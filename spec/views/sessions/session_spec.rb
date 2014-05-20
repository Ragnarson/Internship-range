require 'spec_helper'

describe 'sign in page' do
  before { visit signin_path }

  it 'contain field for email' do
    expect(page).to have_content(
      I18n.t('activerecord.attributes.user.email').capitalize)
  end

  it 'contain field for password' do
    expect(page).to have_content(
      I18n.t('activerecord.attributes.user.password').capitalize)
  end
end
