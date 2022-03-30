class Api::V1::AnalyticsController < ApplicationController

  def create
    Analytic.create!(email: analytics_params[:email], latitude: analytics_params[:current_location][0], longitude: analytics_params[:current_location][1])
    render json: { error: TREASURE_LAT}, status: 201
  end

  private

  def analytics_params
    params.permit(:email, current_location: [])
  end
end
