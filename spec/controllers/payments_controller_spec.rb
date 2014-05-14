require 'spec_helper'

describe PaymentsController do
  let(:payment) { create :payment }

  before do
    request.env['HTTPS'] = 'on'
  end

  describe "GET 'index'" do
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end

    it 'populates an array of payments' do
      get :index
      expect(assigns(:payments)).to eq([payment])
    end
  end

  describe 'GET show' do
    it 'renders the :show view' do
      get :show, id: payment
      expect(response).to render_template :show
    end

    it 'assigns the requested payment to @payment' do
      get :show, id: payment
      expect(assigns(:payment)).to eq(payment)
    end
  end

  describe 'GET new' do
    it 'renders the :new view' do
      get :new
      expect(response.status).to eq(200)
      expect(response).to render_template :new
    end

    it 'assigns the new payment' do
      get :new
      expect(assigns(:payment)).to be_new_record
    end
  end

  describe 'GET edit' do
    it 'renders the :edit view' do
      get :edit, id: payment
      expect(response).to render_template :edit
    end

    it 'assigns the requested payment to @payment' do
      get :edit, id: payment
      expect(assigns(:payment)).to eq(payment)
    end
  end

  describe 'POST create' do
    let(:shooter) { create :shooter }

    context 'with valid attributes' do
      it 'creates a new payment' do
        expect{
          post :create, payment: attributes_for(:payment, shooter_id: shooter)
        }.to change(Payment, :count).by(1)
      end

      it 'redirects to payments#index' do
        attr = attributes_for(:payment)
        attr["shooter_id"] = shooter
        post :create, payment: attr
        expect(response).to redirect_to payments_url
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new payment' do
        expect{
          post :create, payment: attributes_for(:payment, amount: nil)
        }.to_not change(Payment, :count)
      end

      it 're-reders the new method' do
        post :create, payment: attributes_for(:payment, amount: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    let(:shooter){ create :shooter }
    let(:payment){ create :payment, shooter: shooter }

    context 'with valid attributes' do
      it 'assign the requested @payment' do
        put :update, id: payment, payment: attributes_for(:payment)
        expect(assigns(:payment)).to eq(payment)
      end

      it 'changes @payment attributes' do
        put :update, id: payment, payment: attributes_for(:payment, description: "lorem ipsum")
        payment.reload
        expect(payment.description).to eq("lorem ipsum")
      end

      it 'redirects to the updated payment' do
        put :update, id: payment, payment: attributes_for(:payment)
        expect(response).to redirect_to payments_path
      end
    end

    context 'with invalid attributes' do
      it 'assign the requested payment' do
        put :update, id: payment, payment: attributes_for(:payment, amount: nil)
        expect(assigns(:payment)).to eq(payment)
      end

      it "does not change payment attributes" do
        put :update, id: payment, payment: attributes_for(:payment, amount: nil)
        payment.reload
        expect(payment.amount).to_not eq("fourty four")
      end
      it 'render again edit method' do
        put :update, id: payment, payment: attributes_for(:payment, amount: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:payment){ create :payment }

    it 'deletes payment' do
      expect{
        delete :destroy, id: payment
      }.to change(Payment, :count).by(-1)
    end

    it 'redirects to payments#index' do
      delete :destroy, id: payment
      expect(response).to redirect_to payments_url
    end
  end
end
