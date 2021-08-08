# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) { create(:game) }

  before { game }

  describe 'GET show' do
    it 'returns http success' do
      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end
  end
end
