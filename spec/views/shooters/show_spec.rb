require "spec_helper"

describe "shooters/show" do
  subject { page }
  let(:shooter) { create(:shooter) }
  before do
    sign_in
    visit shooter_path(shooter)
  end

  it "displays photo correctly" do
    expect(page).to have_css("img[src*='default.jpg']")
  end

  it "displays shooter's full_name" do
    expect(page).to have_content 'Firstname Lastname'
  end

  it "displays pesel label" do
    expect(page).to have_content t('activerecord.attributes.shooter.pesel')
  end

  it "displays phone label" do
    expect(page).to have_content t('activerecord.attributes.shooter.phone')
  end

  it "displays email label" do
    expect(page).to have_content t('activerecord.attributes.shooter.email')
  end

  it "displays date_of_birth label" do
    expect(page).to have_content t('activerecord.attributes.shooter.date_of_birth')
  end

  it "displays joined_date label" do
    expect(page).to have_content t('activerecord.attributes.shooter.joined_date')
  end

  it "displays resolution_number label" do
    expect(page).to have_content t('activerecord.attributes.shooter.resolution_number')
  end

  it "displays license_number label" do
    expect(page).to have_content t('activerecord.attributes.shooter.license_number')
  end

  it "displays judge_license_number label" do
    expect(page).to have_content t('activerecord.attributes.shooter.judge_license_number')
  end

  it "displays sport_permission label" do
    expect(page).to have_content t('activerecord.attributes.shooter.sport_permission')
  end

  it "displays collectors_permission label" do
    expect(page).to have_content t('activerecord.attributes.shooter.collectors_permission')
  end

  it "displays first_address label" do
    expect(page).to have_content t('shooters.first_address')
  end

  it "displays second_address label" do
    expect(page).to have_content t('shooters.second_address')
  end
end
