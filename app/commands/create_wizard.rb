class CreateWizard
  include Command

  def execute
    @wizard_params = @inputs.wizard_params.except(:item_slots)
    @item_slots_params = @inputs.wizard_params[:item_slots]

    insert_records
  rescue ActiveRecord::RecordInvalid => e
    errors = e.record.errors.full_messages
    @outputs.errors.push(errors)
  end

  def insert_records
    ActiveRecord::Base.transaction do
      @outputs.wizard = Wizard.create!(@wizard_params)
      @outputs.wizard.item_slots.create!(@item_slots_params)
    end
  end
end
