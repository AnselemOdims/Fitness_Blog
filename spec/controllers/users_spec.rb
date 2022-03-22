require 'rails_helper'

RSpec.describe 'Users controller', :type => :request do
  describe 'GET /index' do
    it 'renders the right template' do
      get "/users"

      expect(response).to render_template(:index)
    end
  end
end