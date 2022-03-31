require 'rails_helper'
include ActionView::Helpers::TextHelper
include AnalyticsHelper

describe 'Analytics API', type: :request do
  # test case scenarios for analytics.json api
  describe 'GET /analytics.json' do
    before do
      FactoryBot.create(:analytic, email: 'test@test.com', latitude: 50.051225, longitude: 19.945702)
      FactoryBot.create(:analytic, email: 'test@test.com', latitude: 31.5204, longitude: 74.3587)
      FactoryBot.create(:analytic, email: 'test@test.com', latitude: 31.5204, longitude: 74.3587)
    end

    it 'should return all requests created in 5 minutes' do
      get '/api/v1/analytics.json?from_time='+(DateTime.now.utc - 3.minutes).strftime("%F %T")+'&to_time='+(DateTime.now.utc + 2.minutes).strftime("%F %T")
      expect(response).to have_http_status(:success)
      expect(response_body["requests"].size).to eq(3)
    end

    it 'should return empty requests for last hour' do
      get '/api/v1/analytics.json?from_time='+(DateTime.now.utc - 2.hour).strftime("%F %T")+'&to_time='+(DateTime.now.utc - 1.hour).strftime("%F %T")
      expect(response).to have_http_status(:success)
      expect(response_body["requests"].size).to eq(0)
    end

    it 'should return one request within 5 meters radius' do
      get '/api/v1/analytics.json?radius=5&from_time='+(DateTime.now.utc - 10.minutes).strftime("%F %T")+'&to_time='+(DateTime.now.utc + 10.minutes).strftime("%F %T")
      expect(response).to have_http_status(:success)
      expect(response_body["requests"].size).to eq(1)
    end

    it 'should return no request within 0 meters radius' do
      get '/api/v1/analytics.json?radius=0&from_time='+(DateTime.now.utc - 10.minutes).strftime("%F %T")+'&to_time='+(DateTime.now.utc + 10.minutes).strftime("%F %T")
      expect(response).to have_http_status(:success)
      expect(response_body["requests"].size).to eq(0)
    end

    it 'should return error in case of empty from and to time' do
      get '/api/v1/analytics.json'
      expect(response).to have_http_status(422)
      expect(response_body["status"]).to eq('error')
    end

    it 'should return error in case of invalid from and to time' do
      get '/api/v1/analytics.json?from_time=invalid&to_time=invalid'
      expect(response).to have_http_status(422)
      expect(response_body["status"]).to eq('error')
      expect(response_body["error"]).to eq('please send correct from time and to time')
    end
  end
end