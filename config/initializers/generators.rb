# frozen_string_literal: true

Rails.application.config.generators do |g|
  g.skip_routes true
  g.assets false
  g.helper false
end
