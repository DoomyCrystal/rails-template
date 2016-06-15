namespace :hosting do

  desc 'Prepare oriented.net Hosting for deployment.'
  task :setup do
    info 'Setup ssh-keys for passwordless login'
    role_properties(:app) do |hostname, role, props|
      system "ssh-copy-id #{fetch(:mb_privileged_user)}@#{hostname} -p #{props[:port]}"
    end

    on roles(:app) do
      info 'Stop passenger'
      execute 'cd current'
      execute 'passenger stop --pid-file passenger.pid'
      info 'Delete test-app'
      execute :cd, '..'
      execute :rm, '-rf', './current'
      execute :rm, '-rf', './onapp'
    end

    info 'Setup folders and shared-files'
    invoke 'mb:postgresql:database_yml'
    invoke 'mb:dotenv:update'
    invoke 'mb:newrelic:newrelic_yml'
    invoke 'deploy:check'

    info 'We\'re deploying the app now'
    invoke 'deploy'

    on roles(:app) do
      info 'We start the passenger once, later a touch tmp/restart.txt will be sufficient'
      execute 'passenger start --socket ./current/tmp/sockets/passenger.socket -e production -d'
    end
    info 'Done! Your new oriented.net hosting should be correctly setup now.'
  end

end