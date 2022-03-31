module AnalyticsHelper
  class AnalyticsPresenter
    include ActionView::Helpers::TextHelper

    def initialize(attempts, singular = false)
      @data = attempts
      @singular = singular
    end

    def as_json
      response = {}
      if @singular
        response[:requests] = {
          email: @data.email,
          current_location: [@data.latitude,@data.longitude]
        }
      else
        response[:requests] = @data.map do |request|
          {
            email: request.email,
            current_location: [request.latitude,request.longitude]
          }
        end
      end
      response
    end

    private

    attr_accessor :data
  end
end
