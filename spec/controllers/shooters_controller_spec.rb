require 'spec_helper'

describe ShootersController do
  before { request.env['HTTPS'] = 'on' }

  describe 'GET index' do
    let(:shooter) { create :shooter }
    let(:other_shooter) { create :other_shooter }

    it 'populates an array of shooters' do
      get :index
      expect(assigns(:shooters)).to eq ([shooter, other_shooter])
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET names' do
    let!(:shooter) { create :shooter }
    let!(:other_shooter) { create :other_shooter }

    it 'returns JSON' do
      get :names
      expect(lambda { JSON.parse(response.body) }).to_not raise_error
    end

    it 'renders all shooters in json format' do
      get :names
      expect(JSON.parse(response.body).length).to eq(2)
    end

    it 'renders JSON contained only id and full_names of shooters' do
      get :names
      json = JSON.parse(response.body).first
      expect(json.length).to eq(2)
      expect(json['id']).to eq(shooter.id)
      expect(json['full_name']).to eq(shooter.full_name)
    end
  end

  describe 'DELETE destroy' do
    let!(:shooter) { create :shooter }

    it 'deletes shooter' do
      expect{
        delete :destroy, id: shooter
      }.to change(Shooter, :count).by(-1)
    end

    it 'redirects to shooter#index' do
      delete :destroy, id: shooter
      expect(response).to redirect_to shooters_url
    end
  end
end
