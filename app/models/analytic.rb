class Analytic < ApplicationRecord
  validates :email, :latitude, :longitude, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :latitude , numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
end
