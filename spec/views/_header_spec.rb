require "spec_helper"

describe 'menu nav bar' do
  before do
    visit root_url
  end
  
  describe "context for non sign in user" do
    it "have hidden link to contests" do
      expect(page).to have_no_link(I18n.t('mainmenu.contests'))
    end  

    it 'have hidden link to shooters' do
      expect(page).to have_no_link(I18n.t('mainmenu.shooters'))
    end  

    it 'have hidden link to payments' do
      expect(page).to have_no_link(I18n.t('mainmenu.payments'))
    end  

    it 'have hidden link to admin_panel' do
      expect(page).to have_no_link(I18n.t('mainmenu.admin_panel'))
    end  

    it 'have hidden link to log_out' do
      expect(page).to have_no_link(I18n.t('mainmenu.log_out'))
    end  	
  end	
end
