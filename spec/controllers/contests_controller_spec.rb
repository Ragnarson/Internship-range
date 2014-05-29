require 'spec_helper'

describe ContestsController do
  let!(:resource) { create(:contest) }
  let(:other_resource) { attributes_for(:other_contest) }
  let(:invalid_resource) { attributes_for(:invalid_contest) }

  before { request.env['HTTPS'] = 'on' }

  it_behaves_like "GET #index" do
    subject { :contests }
  end

  subject { :contest }

  it_behaves_like "GET #show"
  it_behaves_like "GET #new"
  it_behaves_like "GET #edit"
  it_behaves_like "POST create"
  it_behaves_like "PUT update"
  it_behaves_like "DELETE destroy"

  describe "GET #index archive" do
    let!(:other_contest) { create(:other_contest) }

    before do
      sign_in
      get :index_archive
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_ok
    end

    it "renders the index template" do
      expect(response).to render_template("index_archive")
    end

    it "loads all of the resources into @resources" do
      expect(assigns(:contests)).to eq([other_contest])
    end
  end

  describe "GET #select" do
    let(:other_contest) { create(:other_contest) }
    before do
      sign_in
      get :select, id: other_contest
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_ok
    end

    it "renders the select template" do
      expect(response).to render_template("select")
    end

    it "loads the resource into @contest" do
      expect(assigns(:contest)).to eq(other_contest)
    end
  end
end
