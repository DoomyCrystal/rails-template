domain_name = ask_with_default('Domain Name?', :blue, 'example.com')
database = ask_with_default('Database Name?', :blue, 'examplecom001')
database_user = ask_with_default('Database User?', :blue, 'examplecom')
database_host = ask_with_default('Database Host?', :blue, 'onhp-db1.iron.oriented.ch')

append_to_file 'config/deploy.rb' do
  <<-VARS.strip_heredoc
    set :mb_recipes, %w(
      dotenv
      seed
      version
      newrelic
    )
    set :deploy_to, '/var/www/#{domain_name}'
    set :keep_releases, 3
    set :mb_privileged_user, '#{privileged_user}'
    set :mb_postgresql_database, '#{database}'
    set :mb_postgresql_user, '#{database_user}'
    set :mb_postgresql_host, '#{database_host}'
    set :linked_files, -> {
      [fetch(:mb_dotenv_filename)] +
          %w(
              config/database.yml
              config/newrelic.yml
            )
    }
    set :passenger_restart_with_touch, true
    set :rbenv_ruby, File.read('.ruby-version').strip
  VARS
end