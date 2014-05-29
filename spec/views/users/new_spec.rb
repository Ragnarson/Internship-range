require 'spec_helper'

describe 'payments/new' do
  subject { page }
  let(:user) { build(:user) }
  before do
    sign_in
    visit new_user_path
  end

  it 'displays field for email' do
    expect(page).to have_field(I18n.t('activerecord.attributes.user.email'))
  end

  it 'displays field for password' do
    expect(page).to have_field(I18n.t('activerecord.attributes.user.password'))
  end

  it 'displays field for password confirmation' do
    expect(page).to have_field(I18n.t(
      'activerecord.attributes.user.password_confirmation'))
  end

  it 'adds new user' do
    fill_in (I18n.t('activerecord.attributes.user.email')),
     with: 'foobar@example.com'
    fill_in (I18n.t('activerecord.attributes.user.password')),
     with: 'password'
    fill_in (I18n.t('activerecord.attributes.user.password_confirmation')),
     with: 'password'

    click_button(I18n.t('helpers.submit.create', model: I18n.t('user.user')))

      expect(page).to have_content I18n.t(
        'flash.success_create', model: I18n.t('user.user'))
  end

  it "displays nav-second-level users" do
    expect(page).to have_selector('li', text: t('user.list'))
  end
end
