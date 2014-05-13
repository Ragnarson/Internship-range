require 'spec_helper'

describe ContestsController do
  let!(:contest) { create(:contest) }
  let(:other_contest) { attributes_for(:other_contest) }
  let(:invalid_contest) { attributes_for(:invalid_contest) }

  describe "GET #index" do
    before do
      get :index
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_ok
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "loads all of the contests into @contests" do
      expect(assigns(:contests)).to eq([contest])
    end
  end

  describe "GET #show" do
    before do
      get :show, id: contest
    end

    it "assigns the requested contest to @contest" do
      expect(assigns(:contest)).to eq(contest)
    end

    it "renders the #show view" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "renders the #new view" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #edit" do
    before do
      get :edit, id: contest
    end

    it "assigns the requested contest to @contest" do
      expect(assigns(:contest)).to eq(contest)
    end

    it "renders the #edit view" do
      expect(response).to render_template("edit")
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new contest" do
        expect{ post :create, contest: other_contest }.to change(Contest, :count).by(1)
      end

      it "redirects to the new contest" do
        post :create, contest: other_contest
        expect(response).to redirect_to Contest.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new contest" do
        expect{ post :create, contest: invalid_contest }.to_not change(Contest, :count)
      end

      it "re-renders the new method" do
        post :create, contest: invalid_contest
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    before :each do
      @contest = contest
    end

    context "valid attributes" do
      it "located the requested @contest" do
        put :update, id: @contest, contest: other_contest
        expect(assigns(:contest)).to eq(@contest)
      end

      it "changes @contest's attributes" do
        put :update, id: @contest, contest: other_contest
        @contest.reload
        expect(@contest.name).to eq(other_contest[:name])
        expect(@contest.date).to eq(other_contest[:date].to_date)
      end

      it "redirects to the updated contest" do
        put :update, id: @contest, contest: other_contest
        expect(response).to redirect_to @contest
      end
    end

    context "invalid attributes" do
      it "locates the requested @contest" do
        put :update, id: @contest, contest: invalid_contest
        expect(assigns(:contest)).to eq(@contest)
      end

      it "does not change @contest's attributes" do
        put :update, id: @contest, contest: invalid_contest
        @contest.reload
        expect(@contest.name).not_to eq(nil)
        expect(@contest.date).not_to eq(nil)
      end

      it "re-renders the edit method" do
        put :update, id: @contest, contest: invalid_contest
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @contest = contest
    end

    it "deletes the contest" do
      expect{ delete :destroy, id: @contest }.to change(Contest, :count).by(-1)
    end

    it "redirects to contests#index" do
      delete :destroy, id: @contest
      expect(response).to redirect_to contests_url
    end
  end
end
