class ApplicationController < ActionController::API
  # adding error helper
  include ErrorsHelper
  # ensuring json request
  before_action :ensure_json_request
  # latitude and longitude of treasure
  TREASURE_LAT = ENV['TREASURE_LAT'] || 50.051227.freeze
  TREASURE_LNG = ENV['TREASURE_LNG'] || 19.945704.freeze
  # we need to calculate distance within 5 meters of treasure's radius by default
  RADIUS_IN_METERS = ENV['RADIUS_IN_METERS'] || 5.freeze

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_not_found(e)
    return render json: ErrorsPresenter.new({status: 'error', description: 'record not found', distance: -1}).as_json, status: :not_found
  end

  def record_invalid(e)
    return render json: ErrorsPresenter.new({status: 'error', description: e.message, distance: -1}).as_json, status: :unprocessable_entity
  end

  def ensure_json_request
    if request.format != :json
      render json: ErrorsPresenter.new({status: 'error', description: 'please send correct json format', distance: -1}).as_json, :status => 406
    end
  end
end
