require 'spec_helper'

describe 'shooter/show' do
  subject { page }
  let(:shooter){ create(:extended) }
  let!(:payment){ create(:payment, shooter: shooter) }
  before do
    sign_in
    visit shooter_path(shooter)
  end

  describe 'photo' do
    it "displayed correctly" do
      expect(page).to have_css("img[src*='default.jpg']")
    end
  end
  describe 'table with informations' do
    it 'exists' do
      expect(page).to have_selector('#shooter_data')
    end

    it 'have cell with label for pesel' do
      expect(page).to have_selector('tr#pesel td:nth-of-type(1)',
        text: t('activerecord.attributes.shooter.pesel'))
    end

    it 'have cell with shooters pesel' do
      expect(page).to have_selector('tr#pesel td:nth-of-type(2)',
        text: shooter.pesel )
    end

    it 'have cell with label for phone' do
      expect(page).to have_selector('tr#phone td:nth-of-type(1)',
        text: t('activerecord.attributes.shooter.phone'))
    end

    it 'have cell with shooters phone' do
      expect(page).to have_selector('tr#phone td:nth-of-type(2)',
        text: shooter.phone )
    end

    it 'have cell with label for email' do
      expect(page).to have_selector('tr#email td:nth-of-type(1)',
        text: t('activerecord.attributes.shooter.email'))
    end

    it 'have cell with shooters email' do
      expect(page).to have_selector('tr#email td:nth-of-type(2)',
        text: shooter.email )
    end

    it 'have cell with label for date_of_birth' do
      expect(page).to have_selector('tr#date_of_birth td:nth-of-type(1)',
        text: t('activerecord.attributes.shooter.date_of_birth'))
    end

    it 'have cell with shooters date_of_birth' do
      expect(page).to have_selector('tr#date_of_birth td:nth-of-type(2)',
        text: shooter.date_of_birth )
    end

    it 'have cell with label for resolution_number' do
      expect(page).to have_selector('tr#resolution_number td:nth-of-type(1)',
        text: t('activerecord.attributes.shooter.resolution_number'))
    end

    it 'have cell with shooters resolution_number' do
      expect(page).to have_selector('tr#resolution_number td:nth-of-type(2)',
        text: shooter.resolution_number )
    end

    it 'have cell with label for license_number' do
      expect(page).to have_selector('tr#license_number td:nth-of-type(1)',
        text: t('activerecord.attributes.shooter.license_number'))
    end

    it 'have cell with shooters license_number' do
      expect(page).to have_selector('tr#license_number td:nth-of-type(2)',
        text: shooter.license_number )
    end

    it 'have cell with label for judge_license_number' do
      expect(page).to have_selector('tr#judge_license_number td:nth-of-type(1)',
        text: t('activerecord.attributes.shooter.judge_license_number'))
    end

    it 'have cell with shooters judge_license_number' do
      expect(page).to have_selector('tr#judge_license_number td:nth-of-type(2)',
        text: shooter.judge_license_number )
    end

    it 'have cell with label for sport_permission' do
      expect(page).to have_selector('tr#sport_permission td:nth-of-type(1)',
        text: t('activerecord.attributes.shooter.sport_permission'))
    end

    it 'have cell with shooters weapons' do
      expect(page).to have_selector('tr#sport_permission td:nth-of-type(2)',
        text: display_weapons_for(shooter) )
    end

    context 'if attribute does not exist' do
      before do
        shooter.update_attribute(:license_number, nil)
        visit current_path 
      end
      it 'returns placeholder' do
        expect(page.find('tr#license_number td:nth-of-type(2)')).to have_content('-')
      end
    end
  end

  describe 'h1 with shooters full_name' do
    it 'contains shooter full_name' do
    expect(page).to have_selector('h1', text: shooter.full_name)
    end

    context 'if shooter is not active' do
      before do
        shooter.update_attribute(:active, false)
        visit current_path 
      end

      it 'contains element small with information about it' do
        expect(page.find('h1')).to have_selector('small', text: t('shooters.not_active'))
      end
    end
  end


  describe 'payment form' do
    it 'exists' do
      expect(page).to have_selector('form#payment_form')
    end

    it 'have field with shooter id' do
      expect(page.find('#payment_form')).to have_xpath("//input[@value=#{shooter.id}]")
    end
  end

  describe 'menu' do
    context 'if shoter does not have email' do
      before do
        shooter.update_attribute(:email, nil)
        visit current_path
      end

      it 'do not have link to email' do
        expect(page.find('#menu')).not_to have_link(t('activerecord.attributes.shooter.email'))
      end
    end

    it 'have link to email' do
      expect(page.find('#menu')).to have_link(t('activerecord.attributes.shooter.email'))
    end

    it 'have link to edit' do
      expect(page.find('#menu')).to have_link(t('edit'))
    end

    it 'have link to destroy' do
      expect(page.find('#menu')).to have_link(t('destroy'))
    end
  end

  describe 'table with shooters payments' do
    it 'exists' do
      expect(page).to have_selector('#payments_table')
    end

    it 'have header for payment date' do
      expect(page.find('#payments_table')).to have_selector('th', text: t('payments.payment_date'))
    end

    it 'have header for payment description' do
      expect(page.find('#payments_table')).to have_selector('th', text: t('payments.description'))
    end

    it 'have header for payment amount' do
      expect(page.find('#payments_table')).to have_selector('th', text: t('payments.amount'))
    end

    it 'have header for payment actions' do
      expect(page.find('#payments_table')).to have_selector('th', text: t('payments.actions'))
    end

    it 'contains payment date' do
      expect(page.find('#payments_table')).to have_text(payment.date)
    end

    it 'contains payment description' do
      expect(page.find('#payments_table')).to have_text(payment.description)
    end

    it 'contains payment amount' do
      expect(page.find('#payments_table')).to have_text(change_to_currency(payment.amount))
    end
  end
end
