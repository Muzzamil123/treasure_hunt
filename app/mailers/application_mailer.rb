class ApplicationMailer < ActionMailer::Base
  # latitude and longitude of treasure
  TREASURE_LAT = ENV['TREASURE_LAT'] || 50.051227.freeze
  TREASURE_LNG = ENV['TREASURE_LNG'] || 19.945704.freeze

  default from: 'winners@treasurehunters.com'
  layout 'mailer'
end
