class ContestsController < ApplicationController
  def index
    @contests = Contest.all.page(params[:page])
  end
end