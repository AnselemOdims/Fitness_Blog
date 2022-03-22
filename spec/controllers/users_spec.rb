require 'rails_helper'

RSpec.describe 'Users controller', :type => :request do
  before :each do
    get "/users"
  end
  describe 'GET /index' do
    it 'renders the right template' do
      expect(response).to render_template(:index)
    end

    it 'the response body includes the correct placeholder text' do
      expect(response.body).to include("Here you will find a list of all users")
    end
  end
end