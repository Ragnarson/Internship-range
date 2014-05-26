require 'spec_helper'

describe ContestsController do
  before { request.env['HTTPS'] = 'on' }

  context 'default CRUD actions' do
    let!(:resource) { create(:contest) }
    let(:other_resource) { attributes_for(:other_contest) }
    let(:invalid_resource) { attributes_for(:invalid_contest) }

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
  end

  context 'custom controller actions' do
    let!(:contest) { create(:contest) }
    let!(:archived_contest) { create(:contests_archive) }
    let(:other_archived_contest) { create(:other_contests_archive) }
    before {sign_in}

    describe 'GET archive' do

      it 'respond to get request' do
        get :archive
        expect(response).to be_ok
      end

      it 'populates array of archived contests' do
        get :archive
        expect(assigns(:contests)).to eq([other_archived_contest, archived_contest])
      end

      it 'renders the index template' do
        get :archive
        expect(response).to render_template('index')
      end
    end

    describe 'POST archivate' do
      it 'adds contest to archive' do
        expect {
          post :archive, id: contest
        }.to change { contest.active }.from(true).to(false)
      end
    end
  end
end
