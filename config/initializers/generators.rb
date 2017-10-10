Rails.application.config.generators do |generate|
  # Disable generators we don't need.
  generate.helper false
  generate.javascripts false
  generate.request_specs false
  generate.routing_specs false
  generate.stylesheets false
  generate.test_framework :rspec
  generate.view_specs false
  generate.template_engine :haml
end
