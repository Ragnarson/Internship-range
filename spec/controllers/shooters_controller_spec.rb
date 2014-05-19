require 'spec_helper'

describe ShootersController do
  before do
    sign_in
    request.env['HTTPS'] = 'on'
  end

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

  describe 'GET new' do
    before do
      get :new
    end

    it 'assigns Shooter to @shooter' do
      expect(assigns(:shooter)).to be_a_new(Shooter)
    end

    it 'renders the :new template' do
      expect(response).to render_template(:new)
    end

    it 'assigns two new Addresses to @shoter' do
      expect(
        assigns(:shooter).addresses.length == 2 &&
        assigns(:shooter).addresses.all? do |a|
          a.attributes == Address.new.attributes
        end
        ).to be(true)
    end
  end

  describe 'GET edit' do
    let!(:shooter){ create(:shooter) }
    before do
      get :edit, id: shooter
    end

    it 'renders the :edit template' do
      expect(response).to render_template(:edit)
    end

    it 'assigns shooter to @shooter' do
      expect(assigns(:shooter)).to eq(shooter)
    end

    context 'when has single address' do
      it '@shooter.addresses include shooter address and builded Address' do  
        expect(
          assigns(:shooter).addresses.length == 2 &&
          assigns(:shooter).addresses[0] == shooter.addresses[0] &&
          assigns(:shooter).addresses[1].attributes ==
            Address.new(shooter: shooter).attributes
          ).to be(true)
      end
    end

    context 'when has two addresses' do
      let!(:address){ create(:address, shooter: shooter) }
      before do 
        shooter.addresses.reload
        get :edit, id: shooter
      end

      it '@shooter.addresses include both adresses' do  
        expect(
          assigns(:shooter).addresses.length == 2 &&
          assigns(:shooter).addresses[0] == shooter.addresses[0] &&
          assigns(:shooter).addresses[1] == shooter.addresses[1]
          ).to be(true)
      end
    end

  end
  describe 'POST create' do
    
    context 'with valid attributes' do
      it 'change number of shooters by 1' do
                shooter_attribs = attributes_for(:shooter)
        shooter_attribs[:addresses_attributes] = {
          "0" => attributes_for(:address)
          }
        expect do
          post(:create, shooter: shooter_attribs)
        end.to change{ Shooter.all.count }.by(1)
      end

      it 'redirects to show new shooter' do
        shooter_attribs = attributes_for(:shooter)
        shooter_attribs[:addresses_attributes] = {
          "0" => attributes_for(:address)
          }

        post(:create, shooter: shooter_attribs)
        expect(response).to redirect_to Shooter.last
      end
    end

    context 'with invalid attributes' do
      it 'not change number of shooters' do
        shooter_attribs = attributes_for(:invalid_shooter)
        shooter_attribs[:addresses_attributes] = {
          "0" => attributes_for(:address)
        }
        expect do
          post(:create, shooter: shooter_attribs)
        end.not_to change{ Shooter.all.count }
      end
    end

    context 'with invalid address' do
      it 'not change number of shooters' do
        shooter_attribs = attributes_for(:shooter)
        shooter_attribs[:addresses_attributes] = {
          "0" => attributes_for(:invalid_address)
        }
        expect do
          post(:create, shooter: shooter_attribs)
        end.not_to change{ Shooter.all.count }
      end
    end

    context 'with one valid and one invalid' do
      it 'change number of shooters by 1' do
        shooter_attribs = attributes_for(:shooter)
        shooter_attribs[:addresses_attributes] = {
          "0" => attributes_for(:address),
          "1" => attributes_for(:invalid_address)
        }
        expect do
          post(:create, shooter: shooter_attribs)
        end.to change{ Shooter.all.count }.by(1)
      end
    end
  end

  context 'with two valid addresses' do
    it 'change number of shooters by 2' do
      shooter_attribs = attributes_for(:shooter)
      shooter_attribs[:addresses_attributes] = {
        "0" => attributes_for(:address),
        "1" => attributes_for(:other_address)
      }
      expect do
        post(:create, shooter: shooter_attribs)
      end.to change{ Shooter.all.count }.by(1)
    end
  end

  describe 'PUT update' do
    let!(:shooter){ create(:shooter) }

    context 'with valid attributes' do
      let(:shooter_attribs){ attributes_for(:other_shooter) }
      it 'assigns shooter to @shooter' do
        shooter_attribs[:addresses_attributes] = {
          "0" => attributes_for(:address)
        }
        put :update, id: shooter, shooter: shooter_attribs
        expect(assigns(:shooter)).to eq(shooter)
      end

      it 'changes shooter attributes' do
        shooter_attribs[:addresses_attributes] =
          { "0" => attributes_for(:address) }
        put :update, id: shooter, shooter: shooter_attribs
        shooter.reload
        expect(
          attributes_for(:other_shooter).all?{|k, v| shooter.send(k) == v }
          ).to be(true)
      end

      it 'changes address' do
        shooter_attribs[:addresses_attributes] = {
          "0" => attributes_for(:other_address, id: shooter.addresses[0])
        }
        put :update, id: shooter, shooter: shooter_attribs
        shooter.addresses.reload
        expect(
          attributes_for(:other_address).all?{|k, v|shooter.addresses[0].send(k) == v.to_s }
          ).to be(true)        
      end
    end

    context 'with invalid values' do

      let(:shooter_attribs){ attributes_for(:invalid_shooter) }
      it 'not change shooter' do
        shooter_attribs[:addresses_attributes] = {
          "0" => attributes_for(:address)
        }
        expect do
          put :update, id: shooter, shooter: shooter_attribs
        end.not_to change{shooter}
      end

      it 'not change address' do
        shooter_attribs[:addresses_attributes] = {
          "0" => attributes_for(:address, id: shooter.addresses[0])
        }
        put :update, id: shooter, shooter: shooter_attribs
        shooter.addresses.reload
        expect(
          attributes_for(:other_address).all? do |k, v|
            shooter.addresses[0].send(k) == v.to_s 
            end
          ).to be(false)
      end
    end
  end
end
