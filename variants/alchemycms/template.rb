source_paths.unshift(File.dirname(__FILE__))

apply 'Gemfile.rb'
copy_file 'app/views/alchemy/pages/_meta_data.html.erb', force: true
template 'app/views/layouts/application.html.erb.tt', force: true
copy_file 'config/locales/alchemy.de.yml', force: true
directory 'vendor/assets/javascripts/alchemy_i18n'
directory 'vendor/assets/javascripts/flatpickr'
copy_file 'vendor/assets/javascripts/alchemy/admin/all.js', force: true

remove_file 'app/controllers/home_controller.rb'
remove_file 'app/views/home/index.html.haml'
FileUtils.rm_r File.expand_path('app/views/home', destination_root)

run 'bundle update'
run 'bin/rake alchemy:mount'
run 'bin/rails g alchemy:install --skip-demo-files'
`bundle exec rake railties:install:migrations`
run 'bin/rails g alchemy:devise:install'
insert_into_file 'db/seeds.rb', "Alchemy::Seeder.seed!\n"
route %Q(mount Alchemy::Engine => '/'\n)

# copy our customized config-file
template 'config/alchemy/config.yml.tt', force: true

run 'bin/rake db:migrate db:seed'
