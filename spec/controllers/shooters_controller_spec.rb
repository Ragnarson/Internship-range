require 'spec_helper'

describe ShootersController do
  before { request.env['HTTPS'] = 'on' }

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
