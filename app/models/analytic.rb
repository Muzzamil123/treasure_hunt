require 'analytics_helper'
class Analytic < ApplicationRecord

  # validations
  validates :email, :latitude, :longitude, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :latitude , numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  # scopes
  scope :created_between, lambda {|start_date, end_date| where("created_at >= ? AND created_at <= ?", start_date, end_date )}
end
