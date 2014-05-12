class ShootersController < ApplicationController
  def new
    @shooter = Shooter.new
  end

  def edit
    @shooter = Shooter.find(params[:id])
  end
  #Important we need add strong params for model
end
