require 'spec_helper'

describe PaymentsController do
  let(:shooter) { create :shooter }
  let(:resource) { create :payment, shooter: shooter }
  let(:other_resource) { attributes_for(:other_payment, shooter_id: shooter.id) }
  let(:invalid_resource) { attributes_for(:invalid_payment) }

  before { request.env['HTTPS'] = 'on' }

  it_behaves_like "GET #index" do
    subject { :payments }
  end

  subject { :payment }

  it_behaves_like "GET #show"
  it_behaves_like "GET #new"
  it_behaves_like "GET #edit"
  it_behaves_like "POST create"
  it_behaves_like "PUT update"
  it_behaves_like "DELETE destroy"
end
