require 'rails_helper'

RSpec.describe WizardsController, :aggregate_failures, type: :controller do
  describe '#create' do
    before do
      allow(CreateWizard).to receive(:new).with(wizard_params: wizard_params).and_return(create_wizard)
    end

    context 'when parameter are valid' do
      let(:wizard_params) { { 'name' => 'valid parameters' } }
      let(:wizard) { instance_double(Wizard) }
      let(:create_wizard) do
        instance_double(CreateWizard, execute: nil, valid?: true, outputs: double(wizard: wizard))
      end
      let(:wizard_serializer) { instance_double(WizardSerializer) }

      before do
        allow(WizardSerializer).to receive(:new).with(wizard).and_return(wizard_serializer)
        allow(wizard_serializer).to receive(:as_json).with(with_item_slots: true).and_return(wizard_params)
      end

      it 'responds with status created' do
        post :create, params: { wizard: wizard_params }

        expect(response).to have_http_status :created
        expect(JSON.parse(response.body)).to eq('name' => 'valid parameters')
      end
    end

    context 'when parameters are invalid' do
      let(:wizard_params) { { 'name' => 'invalid parameters' } }
      let(:create_wizard) do
        instance_double(CreateWizard, execute: nil, valid?: false, errors: ['Something went wrong!'])
      end

      it 'responds with status bad request' do
        post :create, params: { wizard: wizard_params }
        expect(response).to have_http_status :bad_request
        expect(JSON.parse(response.body)).to eq(['Something went wrong!'])
      end
    end
  end
end
