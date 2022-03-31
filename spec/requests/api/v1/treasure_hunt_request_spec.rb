require 'rails_helper'
include ActionView::Helpers::TextHelper
include AnalyticsHelper

describe 'Treasure hunt API', type: :request do
  # Test case scenarios for treasure_hunt.json api
  describe 'GET /treasure_hunt.json' do

    it 'should create a request record in database with valid params' do
      expect {
        post '/api/v1/treasure_hunt.json',
           params: {
               email: "test@test.com",
               current_location: [50.051225, 19.945702]
           }
      }.to change { Analytic.count }.from(0).to(1)
      expect(response).to have_http_status(:success)
      expect(response_body["status"]).to eq('ok')
    end

    it 'should create a winner record in case of nearest lat lng i.e. within 5 meters of treasure' do
      expect {
        post '/api/v1/treasure_hunt.json',
             params: {
                 email: "test@test.com",
                 current_location: [50.051225, 19.945702]
             }
      }.to change( Sidekiq::Worker.jobs, :size ).by(1)
      expect(response).to have_http_status(:success)
    end

    it 'should not create a winner record if lat lngs are not within 5 meters of treasure' do
      expect {
        post '/api/v1/treasure_hunt.json',
             params: {
                 email: "test@test.com",
                 current_location: [50.051335, 19.945321]
             }
      }.to_not change { Winner.count }
      expect(response).to have_http_status(:success)
    end

    it 'should not create a request record in database with invalid email' do
      expect {
        post '/api/v1/treasure_hunt.json',
             params: {
                 email: "test",
                 current_location: [50.051225, 19.945702]
             }
      }.to_not change { Analytic.count }
      expect(response).to have_http_status(422)
      expect(response_body["status"]).to eq('error')
    end

    it 'should not create a request record in database with invalid latitude and longitude' do
      expect {
        post '/api/v1/treasure_hunt.json',
             params: {
                 email: "test@test.com",
                 current_location: ['invalid', 'invalid']
             }
      }.to_not change { Analytic.count }
      expect(response).to have_http_status(422)
      expect(response_body["status"]).to eq('error')
    end
  end
end