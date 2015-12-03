namespace :hosting do

  desc "Setup a Hosttech-Hosting using capistrano-mb's tools and scripts."
  task :setup do
    # invoke tasks from capistrano-mb
    [
        'delayed_job:init_d', 'dotenv:update', 'logrotate', 'nginx:configure',
        'postgresql:create_user', 'postgresql:create_database', 'postgresql:database_yml', 'postgresql:pgpass',
        'postgresql:logrotate_backup', 'ssl:generate_dh', 'ssl:generate_self_signed_crt',
        'unicorn:init_d', 'unicorn:config_rb', 'nginx:restart'
    ].each do |task|
      invoke "mb:#{task}"
    end
  end

end