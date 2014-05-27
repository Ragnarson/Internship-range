require "spec_helper"

describe 'contests/edit.html.haml' do
  before do
    assign(:contest, create(:contest))
    visit edit_contest_path(:contest)
    render
  end

  it "displays label 'Nazwa:" do
    expect(rendered).to have_selector(
      'label',
      text: 'Nazwa'
    )
  end

  it 'displays contest name' do
    expect(rendered).to have_field('Nazwa', with: 'Big contest')
  end

  it "displays label 'Data:'" do
    expect(rendered).to have_selector('label', text: 'Data')
  end

  it 'displays contest date' do
    expect(rendered).to have_field('Data', with: '2014-08-26')
  end

  it 'has a link to add new competitor' do
    expect(rendered).to have_link(t(:add_competitor, scope: :contest))
  end

  it 'has a link to add new judge' do
    expect(rendered).to have_link(t(:add_judge, scope: :contest))
  end

  it 'has a button to confirm update' do
    expect(rendered).to have_button(I18n.t('helpers.submit.update', model: I18n.t('activerecord.models.contest')))
  end
end
