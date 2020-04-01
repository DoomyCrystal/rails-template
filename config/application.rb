gsub_file 'config/application.rb',
          "# config.time_zone = 'Central Time (US & Canada)'",
          'config.time_zone = "Europe/Berlin"'

insert_into_file 'config/application.rb', before: /^  end/ do
  <<-'RUBY'
    config.i18n.default_locale = :de
  RUBY
end
