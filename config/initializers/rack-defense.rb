Rack::Defense.setup do |config|
  config.throttle('treasure_hunt', 20, 1.hour.in_milliseconds) do |req|
    req.ip if req.path == '/api/v1/treasure_hunt.json' && req.post?
  end
end