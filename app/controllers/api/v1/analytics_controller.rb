class Api::V1::AnalyticsController < ApplicationController
  include AnalyticsHelper

  # creates record for all attempts
  def create
    # it will raise an exception if any argument is wrong
    created_record = Analytic.create!(email: analytics_params[:email],
                                latitude: analytics_params[:current_location][0],
                                longitude: analytics_params[:current_location][1]
    )
    distance_between = Geocoder::Calculations.distance_between([created_record.latitude, created_record.longitude], [TREASURE_LAT, TREASURE_LNG]) * 1000
    is_winner?(created_record, distance_between)
    return render json: {status: 'ok', distance: distance_between}, status: :ok
  end

  # returns stats of requests
  def stats
    # checking params validity
    begin
      from_time = DateTime.parse(stats_params[:from_time])
      to_time = DateTime.parse(stats_params[:to_time])
    rescue
      return render json: ErrorsPresenter.new({description: 'please send correct from time and to time'}).as_json, status: :unprocessable_entity
    end
    all_records = Analytic.created_between(from_time, to_time)

    if stats_params[:radius].present?
      records = []
      # filtering records within specific radius
      all_records.each do |record|
        near_records = Geocoder::Calculations.
          distance_between([record.latitude, record.longitude], [TREASURE_LAT, TREASURE_LNG]) * 1000
        if near_records <= stats_params[:radius].to_f
          records << record
        end
      end
      all_records = records
    end

    return render json: AnalyticsPresenter.new(all_records, false).as_json, status: :ok
  end

  private

  def analytics_params
    params.permit(:email, current_location: [])
  end

  def stats_params
    params.permit(:from_time, :to_time, :radius)
  end

  # logic to determine winner of treasure hunt
  def is_winner?(created_record, distance_between)
    winner = false
    if distance_between < RADIUS_IN_METERS
      # create winner record
      winner_record = Winner.create(email: created_record.email, last_location: "#{created_record.latitude},#{created_record.longitude}")
      unless winner_record.errors.any?
        winner = true
      end
    end
    winner
  end
end
