comment_lines 'config/environments/production.rb',
              /config\.assets\.js_compressor = :uglifier/

insert_into_file 'config/environments/production.rb',
                 after: /# config\.assets\.css_compressor = :sass\n/ do
  <<-RUBY

  # Disable minification since it adds a *huge* amount of time to precompile.
  # Anyway, gzip alone gets us about 70% of the benefits of minify+gzip.
  # UPDATE: we re-enable it for a time to watch how it performs.
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass
  RUBY
end

uncomment_lines 'config/environments/production.rb',
                /config\.action_dispatch\.x_sendfile_header = 'X-Accel-Redirect' # for NGINX/i
uncomment_lines 'config/environments/production.rb', /config\.force_ssl = true/

insert_into_file 'config/environments/production.rb',
                 after: /# config\.action_mailer\.raise_deliv.*\n/ do
  <<-RUBY

  # Production Mailgun config
  config.action_mailer.delivery_method = :mailgun
  config.action_mailer.mailgun_settings = {
      api_key: ENV.fetch('MAILGUN_API_KEY'),
      domain: ENV.fetch('MAILGUN_DOMAIN')
  }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = {
    host: '#{production_hostname}',
    protocol: 'https'
  }
  config.action_mailer.asset_host = 'https://#{production_hostname}'
  RUBY
end
