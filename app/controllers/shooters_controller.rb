class ShootersController < ApplicationController
  def index
    @shooters = Shooter.page(params[:page])
  end
end
