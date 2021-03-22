class WizardsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    command = CreateWizard.new(wizard_params: wizard_params)
    command.execute

    if command.valid?
      wizard = command.outputs.wizard
      render status: :created, json: WizardSerializer.new(wizard).as_json(with_item_slots: true)
    else
      render status: :bad_request, json: command.errors
    end
  end

  private

  def wizard_params
    params
      .permit(:name, :gender, :location_x, :location_y, :gold, item_slots: %i[item_id quantity])
  end
end
