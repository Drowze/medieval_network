class WizardsController < ApplicationController
  def create
    wizard = Wizard.new(wizard_params)

    if wizard.save
      render status: :created, json: wizard
    else
      render status: :bad_request, json: {}
    end
  end

  private

  def wizard_params
    params.require(:wizard).permit(:name, :gender, :location_x, :location_y)
  end
end
