source_paths.unshift(File.dirname(__FILE__))

apply 'config/deploy.rb'
apply 'Capfile.rb'
apply 'Gemfile'
template 'config/deploy/production.rb.tt', force: true
template 'config/deploy/staging.rb.tt', force: true
