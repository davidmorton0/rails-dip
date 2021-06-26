# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'GET show' do
    it 'returns http success' do
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
    end
  end
end
