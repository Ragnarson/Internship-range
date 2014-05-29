require 'spec_helper'

describe CompetitionsController do
  let!(:contest) { create(:contest) }
  let!(:competition) { create(:competition, contest: contest) }

  before do
    sign_in
    request.env['HTTPS'] = 'on'
  end

end
