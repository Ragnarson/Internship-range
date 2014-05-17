require 'spec_helper'

describe ContestsController do
  it_should_behave_like("accessible by user")
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
end
