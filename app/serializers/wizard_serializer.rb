class WizardSerializer
  def initialize(record)
    @record = record
  end

  def as_json(with_item_slots: false)
    @record.as_json.tap do |h|
      if with_item_slots
        h[:item_slots] = @record.item_slots.as_json(only: %i[item_id quantity])
      end
    end
  end
end
