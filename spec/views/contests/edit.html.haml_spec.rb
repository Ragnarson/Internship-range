require "spec_helper"

describe 'contests/edit.html.haml' do
  let!(:contest) { create(:contest) }
  before do
    sign_in
    visit edit_contest_path(contest)
  end

  it "displays label 'Nazwa:" do
    expect(page).to have_selector('label', text: 'Nazwa')
  end

  it 'displays contest name' do
    expect(page).to have_field('Nazwa', with: contest.name)
  end

  it "displays label 'Data:'" do
    expect(page).to have_selector('label', text: 'Data')
  end

  it 'displays contest date' do
    expect(page).to have_field('Data', with: '2014-08-26')
  end

  it 'has a link to add new competitor' do
    expect(page).to have_link(t(:add_competitor, scope: :contest))
  end

  it 'has a link to add new judge' do
    expect(page).to have_link(t(:add_judge, scope: :contest))
  end

  it 'has a button to confirm update' do
    expect(page).to have_button(I18n.t('helpers.submit.update', model: I18n.t('activerecord.models.contest')))
  end
end
