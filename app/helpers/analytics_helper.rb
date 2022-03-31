module AnalyticsHelper
  class AnalyticsPresenter
    include ActionView::Helpers::TextHelper

    def initialize(attempts, singular = false)
      @data = attempts
      @singular = singular
    end

    def as_json
      if @singular
        {
          status: 'error',
          descrition: data.description,
          error: data.error
        }
      else
        data.map do |request|
          {
            "requests": {
              id: request.id,
              name: request.email,
              description: request.latitude,
              location: request.longitude,
            }
          }
        end
      end
    end

    private

    attr_accessor :data
  end
end
