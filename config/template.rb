apply 'config/application.rb'
copy_file 'config/brakeman.yml'
template 'config/critical_path_css.yml.tt'
template 'config/database.example.yml.tt'
remove_file 'config/database.yml'
copy_file 'config/puma.rb', force: true
remove_file 'config/secrets.yml'

if apply_capistrano?
  template 'config/deploy.rb.tt'
  template 'config/deploy/production.rb.tt'
  template 'config/deploy/staging.rb.tt'
end

gsub_file 'config/routes.rb', /  # root 'welcome#index'/ do
  '  root "home#index"'
end

copy_file 'config/initializers/active_job.rb'
copy_file 'config/initializers/generators.rb'
copy_file 'config/initializers/rotate_log.rb'
copy_file 'config/initializers/secret_token.rb'
copy_file 'config/initializers/serviceworker.rb'
copy_file 'config/initializers/version.rb'

gsub_file 'config/initializers/filter_parameter_logging.rb', /\[:password\]/ do
  '%w[password secret session cookie csrf]'
end

append_to_file 'config/initializers/assets.rb', 'Rails.configuration.assets.precompile += %w[serviceworker.js]'

template 'config/locales/de.yml.tt'

apply 'config/environments/development.rb'
apply 'config/environments/production.rb'
apply 'config/environments/test.rb'
template 'config/environments/staging.rb.tt'

route 'root "home#index"'