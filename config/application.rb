gsub_file 'config/application.rb',
          "# config.time_zone = 'Central Time (US & Canada)'",
          'config.time_zone = "Europe/Berlin"'

insert_into_file 'config/application.rb', before: /^  end/ do
  <<-'RUBY'
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end  

    config.i18n.default_locale = :de

    # Ensure non-standard paths are eager-loaded in production
    # (these paths are also autoloaded in development mode)
    # config.eager_load_paths += %W(#{config.root}/lib)
  RUBY
end
