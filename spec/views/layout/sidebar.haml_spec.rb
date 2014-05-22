require 'spec_helper'

describe 'sidebar panel' do
  subject { page }

  context 'if signed in' do
    before do
      sign_in
      visit root_path
    end

    it 'renders side bar' do
      expect(page).to have_selector(
        'div.sidebar-collapse')
    end

    it 'renders mainmenu' do
      expect(page).to have_selector(
        'ul#main-menu')
    end

    %w(contents shooters payments admin_panel).each do |item|
      it "contains menu button for #{item}" do
        expect(page).to have_selector('a') do |link|
          expect(link).to contain(i18nt("mainmenu.#{item}"))
        end
      end
    end
  end
end
