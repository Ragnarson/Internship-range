require 'spec_helper'

describe 'header panel' do
  subject { page }

  before(:each) do
    visit root_path
  end

  context 'if signed in' do
    before { sign_in }

    it 'does not contain a name of club' do
      expect(page).to_not have_selector(
        'a.navbar-brand', I18n.t('club_name'))
    end

    it 'does not contain a logout button' do
      expect(page).to_not have_selector(
        'a', I18n.t('actions.signout'))
    end
  end
end
