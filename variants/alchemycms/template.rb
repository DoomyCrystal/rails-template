source_paths.unshift(File.dirname(__FILE__))

apply 'Gemfile.rb'
run_with_clean_bundler_env 'bundle update'
run_with_clean_bundler_env 'bundle exec rails g alchemy:devise:install'
run_with_clean_bundler_env 'bundle exec rails g alchemy:install --skip-demo-files --skip-webpacker-installer'
run_with_clean_bundler_env 'yarn add @alchemy_cms/admin'

# copy our customized config-file
template 'config/alchemy/config.yml.tt', force: true

copy_file 'app/helpers/alchemy_helper.rb'
copy_file 'app/views/alchemy/pages/_meta_data.html.erb', force: true
template 'app/views/layouts/application.html.erb.tt', force: true
copy_file 'config/locales/alchemy.de.yml', force: true
copy_file 'config/locales/devise.de.yml'
copy_file 'lib/tasks/alchemy.rake'
directory 'vendor/assets/javascripts/alchemy_i18n'
directory 'vendor/assets/javascripts/flatpickr'
directory 'vendor/assets/javascripts/tinymce'
copy_file 'vendor/assets/javascripts/select2_locale_de.js'
copy_file 'vendor/assets/javascripts/alchemy/admin/all.js', force: true
copy_file 'vendor/assets/stylesheets/alchemy/admin/all.css', force: true

remove_file 'app/controllers/home_controller.rb'
remove_file 'app/views/home/index.html.haml'
FileUtils.rm_r File.expand_path('app/views/home', destination_root)

run_with_clean_bundler_env 'bundle exec rake db:migrate db:seed'
