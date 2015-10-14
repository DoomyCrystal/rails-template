Rails.application.config.generators do |g|
  # Disable generators we don't need.
  g.stylesheets false
  g.javascripts false
  g.helpers false
  g.template_engine :haml
end
