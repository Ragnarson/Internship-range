require 'spec_helper'

describe 'header panel' do
  subject { page }

  context 'if signed in' do
    before do
      sign_in
      visit root_path
    end

    it 'contains a name of club' do
      expect(page).to have_selector(
        'a.navbar-brand', I18n.t('club_name'))
    end

    it 'contains a logout button' do
      expect(page).to have_selector(
        'a', I18n.t('actions.signout'))
    end
  end
end
