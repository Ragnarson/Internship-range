require 'spec_helper'

describe CompetitionsController do
  let!(:contest) { create(:contest) }
  let!(:competition) { create(:competition, contest: contest) }

  before do
    request.env['HTTPS'] = 'on'
  end

  describe 'GET #new' do
    it "assigns new Competition to @competition" do
      get :new, contest_id: contest
      expect(assigns(:competition)).to be_a_new(Competition)
    end

    it "renders the :new template" do
      get :new, contest_id: contest
      expect(response).to render_template :new
    end
  end
end
