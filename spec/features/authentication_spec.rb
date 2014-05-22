require "spec_helper"

feature "Authentication" do

  before {create(:user)}
  
  scenario "User login on page" do
    visit "/"

    fill_in I18n.t('activerecord.attributes.user.email').capitalize, with: "mike@example.com"
    fill_in I18n.t('activerecord.attributes.user.password').capitalize, with: "Securepass"
    click_button I18n.t('actions.signin')

    expect(page).to have_text(I18n.t('flash.logged_in'))
  end
  
  scenario "User logout" do
    visit "/"

    fill_in I18n.t('activerecord.attributes.user.email').capitalize, with: "mike@example.com"
    fill_in I18n.t('activerecord.attributes.user.password').capitalize, with: "Securepass"
    click_button I18n.t('actions.signin')
    page.find(:xpath, "//a[@href='/signout']").click

    expect(page).to have_text(I18n.t('flash.logged_out'))
  end

  scenario "User not logged in contests" do
    visit "/contests"

    expect(page).to have_text(I18n.t('flash.not_authorized'))
  end

  scenario "User not logged in shooters" do
    visit "/shooters"

    expect(page).to have_text(I18n.t('flash.not_authorized'))
  end

  scenario "User not logged in payments" do
    visit "/payments"

    expect(page).to have_text(I18n.t('flash.not_authorized'))
  end
end
