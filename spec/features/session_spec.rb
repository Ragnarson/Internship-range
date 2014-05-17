require 'spec_helper'

describe " sign in page" do
 before{ visit signin_path }

  it "contains a headline" do
    expect(page).to have_selector('h2', text: I18n.t('signin'))
  end

  it "contain field for email" do
    expect(page).to have_content( I18n.t('email'))
  end

  it "contain field for password" do
    expect(page).to have_content( I18n.t( 'password' ) )
  end
end
