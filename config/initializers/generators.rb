Rails.application.config.generators do |generate|
  # Disable generators we don't need.
  generate.helper false
  generate.assets false
  generate.view_specs false
end
