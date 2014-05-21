require "spec_helper"

describe "View of the Settings panel" do
  subject {page}
  before do
    sign_in
    visit app_configs_path
  end

  it "contains a headline" do
    expect(page).to have_selector(
      'h2', text: I18n.t('mainmenu.admin_panel'))
  end

  it "contains field club logo" do
    expect(page).to have_field(
      I18n.t('activerecord.attributes.app_config.club_logo'))
  end

  it "contains field club name" do
    expect(page).to have_field(
      I18n.t('activerecord.attributes.app_config.club_name'))
  end

  it "containes update settings button" do
    expect(page).to have_css('input.btn.btn-primary')
  end
end
