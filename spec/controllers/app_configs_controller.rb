require 'spec_helper'

describe AppConfigsController do
  let(:app_config) { build :app_config }

  before { request.env['HTTPS'] = 'on' }

  subject { :app_config }

  it_behaves_like "GET #index"

  describe "POST Create" do
    it "create a new record" do
      expect{
        post :create, app_config: FactoryGirl.attributes_for(:app_config)
      }.to change(AppConfig, :count)
    end

    it "it is creating only one record" do
      expect{
        2.times { post :create, app_config: FactoryGirl.attributes_for(:app_config) }
      }.to change(AppConfig, :count).by(1)
    end
  end
end
