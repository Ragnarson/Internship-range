require 'spec_helper'
describe "Shooter new page" do
  before { visit 'shooters/new' }
  let(:title) do
     I18n.t('club_name') << ' - ' << I18n.t(
       'actions.new') << ' ' << I18n.t('activerecord.models.shooter')
  end

  it { expect(page).to have_title(title) }

  it "have page heading 'h2' with create action" do
    expect(page).to have_selector(
      'h2', text: I18n.t('helpers.label.shooter.create'))
    end

  it "have navbar" do
    expect(page).to have_css('header.navbar-fixed-top')
  end

  it "have default hidden Second address fields" do
    expect(page).to have_css('fieldset#second_address', visible: false)
  end

  it "have default hidden weapons choice checkboxes" do
    expect(page).to have_css('div.well.well-sm', visible: false)
  end

  context "for registration form" do
    it "have field for attribute First name" do
      expect(page).to have_field(
        I18n.t('activerecord.attributes.shooter.first_name'))
    end

    it "have field for attribute Last name" do
      expect(page).to have_field(
        I18n.t('activerecord.attributes.shooter.last_name'))
    end

    it "have field for attribute Date of birth" do
      expect(page).to have_field(
        I18n.t('activerecord.attributes.shooter.date_of_birth'))
    end

    it "have field for attribute PESEL" do
       expect(page).to have_field(
         I18n.t('activerecord.attributes.shooter.pesel'))
    end

    it "have field for attribute Email" do
       expect(page).to have_field(
         I18n.t('activerecord.attributes.shooter.email'))
    end

    it "have field for attribute Phone" do
      expect(page).to have_field(
        I18n.t('activerecord.attributes.shooter.phone'))
    end

    it "have field for attribute Joined date" do
      expect(page).to have_field(
        I18n.t('activerecord.attributes.shooter.joined_date'))
    end

    it "have field for attribute Resolution number" do
      expect(page).to have_field(
        I18n.t('activerecord.attributes.shooter.resolution_number'))
    end

    it "have field for attribute License number" do
     expect(page).to have_field(
       I18n.t('activerecord.attributes.shooter.license_number'))
    end

    it "have field for attribute Judge license number" do
      expect(page).to have_field(
        I18n.t('activerecord.attributes.shooter.judge_license_number'))
    end

    it "have Sport permission radiobox label" do
      expect(page).to have_selector(
        'label',
        text: I18n.t('activerecord.attributes.shooter.sport_permission'))
    end

    it "have 'Adres' fieldset heading" do
      expect(page).to have_selector(
        'h5',
        text: I18n.t('activerecord.models.address'))
    end

    it "have Secondary address checkbox label" do
      expect(page).to have_selector(
        'label',
        text: I18n.t('helpers.label.address.second_address'))
    end

    it "have 2 x Yes radio button labels" do
      expect(page).to have_selector(
        'label',
        text: I18n.t('helpers.label.shooter.yes_form'),
        count: 2)
    end

    it "have 2 x Yes radio button labels" do
      expect(page).to have_selector(
        'label',
        text: I18n.t('helpers.label.shooter.no_form'),
        count: 2)
    end

    it "have 2 x Street labels" do
      expect(page).to have_selector(
        'label',
        text: I18n.t('activerecord.attributes.address.street'),
        count: 2)
    end

    it "have 2 x Building number labels" do
      expect(page).to have_selector(
        'label',
        text: I18n.t('activerecord.attributes.address.building'),
        count: 2)
    end

    it "have 2 x Building number labels" do
      expect(page).to have_selector(
        'label',
        text: I18n.t('activerecord.attributes.address.flat'),
        count: 2)
    end

    it "have 2 x City field labels" do
      expect(page).to have_selector(
        'label',
        text: I18n.t('activerecord.attributes.address.city'),
        count: 2)
    end

    it "have button for create action" do
      expect(page).to have_css('input.btn.btn-primary')
    end

    it "have radio button for for sport permission with option 'Yes'" do
      expect(page).to have_css('input#permission_true')
    end

    it "have radio button for for sport permission with option 'No'" do
      expect(page).to have_css('input#permission_false')
    end

    it "have radio button for 'Collectors permission' with option 'Yes'" do
      expect(page).to have_css('input#shooter_collectors_permission_true')
    end

    it "have radio button for 'Collectors permission' with option 'No'" do
      expect(page).to have_css('input#shooter_collectors_permission_false')
    end

    it "have checkbox for 'Secondary address'" do
      expect(page).to have_css('input#second_address_show')
    end
  end
end
