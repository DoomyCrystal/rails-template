insert_into_file 'config/application.rb', before: /^  end/ do
  <<-'RUBY'
    config.i18n.default_locale = :de

    config.time_zone = 'Bern'

    config.exceptions_app = self.routes
  RUBY
end
