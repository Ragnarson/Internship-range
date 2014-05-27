require 'spec_helper'

describe UsersController do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }

  before do
    sign_in
    request.env['HTTPS'] = 'on'
  end

  describe 'GET #index' do
    context 'HTML request' do
      it 'populates an array of shooters' do
        get :index
        expect(assigns(:users)).to eq ([user, other_user])
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it 'assigns User to @user' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the :new template' do
      expect(response).to render_template(:new)
    end
  end
  describe 'GET #edit' do
    before do
      get :edit, id: user
    end

    it 'renders the :edit template' do
      expect(response).to render_template(:edit)
    end

    it 'assigns User to @user' do
      expect(assigns(:user)).to eq(user)
    end
  end

  describe '#delete' do
    it "deletes the user" do
      expect{ delete :destroy, id: user }.to change(User, :count).by(-1)
    end

    it "redirects to resources#index" do
      delete :destroy, id: user
      expect(response).to redirect_to(action: :index)
    end
  end
end

