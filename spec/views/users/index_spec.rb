require 'spec_helper'

describe 'Users index' do
  subject { page }
  let!(:user) { create(:user) }
  before(:each) do
    sign_in
    visit users_path
  end

  it 'contains a headline' do
    expect(page).to have_selector(
      'h2', text: I18n.t('user.list'))
  end

  it 'contains a link to add new user' do
    expect(page).to have_link(I18n.t('user.new'), new_user_path)
  end

  context 'tables' do
    it 'contain email head' do
      expect(page).to have_selector(
        'th', text: I18n.t('activerecord.attributes.user.email'))
    end

    it 'contain actions head' do
      expect(page).to have_selector(
        'th', text: I18n.t('actions.actions'))
    end

    it 'contain users emails' do
      expect(page).to have_selector(
        'td', text: user.email)
    end

    it 'have links to edit user' do
      expect(page).to have_link(I18n.t('actions.edit'))
    end

    it 'have links to delete user' do
      expect(page).to have_link(I18n.t('actions.destroy'))
    end
  end
end
