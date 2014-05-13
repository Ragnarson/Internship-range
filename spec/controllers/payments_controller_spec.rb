require 'spec_helper'

describe PaymentsController do
  let(:payment) { create :payment }
  
  describe "GET 'index'" do
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end

    it "populates an array of payments" do
      get :index
      expect(assigns(:payments)).to eq([payment])
    end
  end

  describe "GET 'show'" do
    it "renders the :show view" do
      get :show, id: payment
      expect(response).to render_template :show
    end

    it "assigns the requested payment to @payment" do
      get :show, id: payment
      expect(assigns(:payment)).to eq(payment)
    end
  end
end
