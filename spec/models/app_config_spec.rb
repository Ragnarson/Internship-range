require 'spec_helper'

describe AppConfig do
  subject(:app_config) { create(:app_config) }

  it { expect(subject).to respond_to(:club_name) }
  it { expect(subject).to respond_to(:club_logo) }

  context "when club_name is nil, return deafault value" do
    before { app_config.club_name = nil }
    it "return default value" do
      expect(subject.club_name).to eq('')
    end
  end
end
