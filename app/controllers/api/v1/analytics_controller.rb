class Api::V1::AnalyticsController < ApplicationController
  include AnalyticsHelper

  # creates record for all attempts
  def create
    request = Analytic.create!(email: analytics_params[:email],
                                latitude: analytics_params[:current_location][0],
                                longitude: analytics_params[:current_location][1]
    )
    is_winner?(request)
  end

  # returns analytics
  def analytics
    begin
    from_time = Date.parse(params['from_time'])
    to_time = Date.parse(params['to_time'])
    rescue
    end
    all_attempts = Analytic.all

    attempts = []
    if params['radius'].present?
      all_attempts.each do |attempt|
        near_bys = Geocoder::Calculations.
          distance_between([attempt.latitude, attempt.longitude], [TREASURE_LAT, TREASURE_LNG]) * 1000
        if near_bys <= params['radius']
          attempts << attempt
        end
      end
    else
      attempts = Analytic.created_between(from_time, to_time)
    end

    render json: AnalyticsPresenter.new(attempts, false).as_json, status: :ok

  end

  private

  def analytics_params
    params.permit(:email, current_location: [])
  end

  # logic to determine winner of treasure hunt
  def is_winner?(request)
    distance = Geocoder::Calculations.distance_between([request.latitude, request.longitude], [TREASURE_LAT, TREASURE_LNG]) * 1000
    if distance <= 5
      already_won = Winner.find_by(email: request.email)
      unless already_won.present?
        winner = Winner.create(email: request.email, last_location: "#{request.latitude.to_f}/#{request.longitude.to_f}")
        winner_mail(winner, distance)
      else
        render json: AnalyticsPresenter.new(winner, false).as_json, status: :created
      end
    else
      render json: { Result: "you failed" }, status: 201
    end
  end

  # send mail in case of win
  def winner_mail(winner, distance)
    WinnerMailer.with(winner: winner).new_winner_email.deliver_now
    render json: { distance: distance }, status: 201
  end
end
