require 'rails_helper'

RSpec.describe WizardsController, type: :controller do
  describe '#create' do
    context 'when parameter are valid' do
      let(:params) do
        {
          name: 'John',
          gender: 'male',
          location_x: 21.4,
          location_y: 43.2
        }
      end

      it 'responds with status created' do
        post :create, params: { wizard: params }
        expect(response).to have_http_status :created
      end

      it 'creates a new wizard' do
        expect { post :create, params: { wizard: params } }
          .to change { Wizard.count }.by(1)
      end

      it 'returns the created wizard' do
        post :create, params: { wizard: params }
        expected_response = { id: Wizard.last.id, gold: 0, **params }
        expect(JSON.parse(response.body, symbolize_names: true)).to include expected_response
      end
    end

    context 'when parameters are not valid' do
      let(:params) { { name: nil } }

      it 'responds with status bad request' do
        post :create, params: { wizard: params }
        expect(response).to have_http_status :bad_request
      end

      it 'does not create a new wizard' do
        expect { post :create, params: { wizard: params } }
          .not_to change { Wizard.count }
      end
    end
  end
end
