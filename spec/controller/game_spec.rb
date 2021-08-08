# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) { create(:game) }

  describe 'GET show' do
    it 'returns http success' do
      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get :show, params: { id: game.id }
      expect(response).to render_template('show')
    end
  end
end
