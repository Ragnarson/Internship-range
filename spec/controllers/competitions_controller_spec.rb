require 'spec_helper'

describe CompetitionsController do
  let!(:contest) { create(:contest) }
  let!(:competition) { create(:competition, contest: contest) }

  before do
    sign_in
    request.env['HTTPS'] = 'on'
  end

  describe 'GET #show' do
    it "renders the template" do
      get :show, { contest_id: contest, id: competition }
      expect(response).to render_template :show
    end
  end
end
