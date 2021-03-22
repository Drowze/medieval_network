require 'rails_helper'

RSpec.describe CreateWizard, :aggregate_failures, type: :controller do
  subject { described_class.new(wizard_params: params) }

  describe '#run' do
    context 'when parameters are valid' do
      let(:item_1) { create(:item, name: 'Oregano', value: 1) }
      let(:item_2) { create(:item, name: 'Robot Vacuum', value: 31) }

      let(:params) do
        {
          name: 'John',
          gender: 'male',
          location_x: 21.4,
          location_y: 43.2,
          gold: 50,
          item_slots: [
            { item_id: item_1.id, quantity: 3 },
            { item_id: item_2.id, quantity: 1 }
          ]
        }
      end

      it 'creates a new wizard, along with their items' do
        expect { subject.run }
          .to change { Wizard.count }.by(1)
          .and change { ItemSlot.count }.by(2)

        wizard = subject.outputs.wizard

        expect(wizard.item_slots.item_name('Oregano').first.quantity).to eq 3
        expect(wizard.item_slots.item_name('Robot Vacuum').first.quantity).to eq 1
      end
    end

    context 'when parameters are not valid' do
      let(:params) { { name: nil } }

      it 'does not create a new wizard' do
        expect { subject.run }
          .to not_change { Wizard.count }
          .and not_change { ItemSlot.count }

        expect(subject).not_to be_valid
      end
    end
  end
end
