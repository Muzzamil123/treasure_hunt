module ErrorsHelper
  class ErrorsPresenter
    include ActionView::Helpers::TextHelper

    def initialize(error)
      @error = error
    end

    def as_json
      parsed_error = {
          status: 'error',
          error: @error[:description]
      }
      if @error[:distance].present?
        parsed_error[:distance] = @error[:distance]
      end
      parsed_error
    end

    private

    attr_accessor :error
  end
end
