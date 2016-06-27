source_paths.unshift(File.dirname(__FILE__))

apply 'Gemfile.rb'
apply 'config/deploy.rb'
apply 'Capfile.rb'
template 'config/deploy/production.rb.tt', force: true
template 'config/deploy/staging.rb.tt', force: true
