source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.5'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Use Factory bot to create factories
  gem 'factory_bot_rails'
  # Use rspec for test cases
  gem 'rspec-rails'
  # Use Faker to create dummy data
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use to preview mails in browser
  gem "letter_opener"

  #
  # Capistrano for deployment
  gem 'capistrano',                 '3.11.2'
  gem 'capistrano-rails',           '1.4.0'
  gem 'capistrano-rbenv',           '2.1.4 '
  gem 'capistrano-passenger',       '0.2.1'
end

group :production do
  gem 'sendgrid-ruby'
end

# Use to perform background jobs
gem 'sidekiq', '~> 6.1.3'
# Redis for caching and mantaining jobs
gem 'redis-rails', '~> 5.0.2'
# Use to check throttling n stuff
gem 'rack-defense'
# Use for geocoding calculations/operations
gem 'geocoder'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
