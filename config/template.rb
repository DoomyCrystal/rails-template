apply 'config/application.rb'
template 'config/database.example.yml.tt'
remove_file "config/database.yml"
copy_file 'config/puma.rb', force: true
remove_file 'config/secrets.yml'
copy_file 'config/sidekiq.yml'

copy_file 'config/initializers/active_job.rb'
copy_file 'config/initializers/generators.rb'
copy_file 'config/initializers/rotate_log.rb'
template 'config/initializers/sidekiq.rb.tt'
copy_file 'config/initializers/version.rb'

gsub_file 'config/initializers/filter_parameter_logging.rb', /\[:password\]/ do
  '%w[password secret session cookie csrf]'
end

template 'config/locales/de.yml.tt'

apply 'config/environments/development.rb'
apply 'config/environments/production.rb'
apply 'config/environments/test.rb'

route 'root "home#index"'
route %Q(mount Sidekiq::Web => '/sidekiq' # monitoring console\n)
