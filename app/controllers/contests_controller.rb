class ContestsController < ApplicationController
  def index
    @contests = Contest.all
  end
end