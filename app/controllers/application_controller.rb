class ApplicationController < ActionController::API
  before_action :ensure_json_request

  TREASURE_LAT = 50.051227.freeze
  TREASURE_LNG = 19.945704.freeze

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_not_found(e)
    render json: { error: "record not found"}, status: :not_found
  end

  def record_invalid(e)
    render json: { error: e.message}, status: 401
  end

  def ensure_json_request
    if request.format != :json
      render json: { error: 'please ensure json request'}, :status => 406
    end
  end
end
