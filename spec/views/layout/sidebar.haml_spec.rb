require 'spec_helper'

describe 'sidebar panel' do
  subject { page }
  before { visit root_path }
  
  context 'if signed in' do
    before { sign_in }

    it 'does not render side bar' do
      expect(page).to_not have_selector(
        'div.sidebar-collapse')
    end

    it 'does not render mainmenu' do
      expect(page).to_not have_selector(
        'ul#main-menu')
    end

    %w(contents shooters payments admin_panel).each do |item|
      it "does not contain menu button for #{item}" do
        expect(page).to_not have_selector('a') do |link|
          expect(link).to_not contain(i18nt("mainmenu.#{item}"))
        end
      end
    end
  end
end
