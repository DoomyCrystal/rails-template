source_paths.unshift(File.dirname(__FILE__))

apply 'Gemfile.rb'
run_with_clean_bundler_env 'bundle update'
run_with_clean_bundler_env 'bundle exec rails g alchemy:devise:install'
run_with_clean_bundler_env 'bundle exec rails g alchemy:install --skip-demo-files --skip-webpacker-installer'

# copy our customized config-file
template 'config/alchemy/config.yml.tt', force: true

copy_file 'app/controllers/alchemy/admin/passwords_controller.rb'
copy_file 'app/helpers/alchemy_helper.rb'
copy_file 'app/javascripts/packs/alchemy/admin.js'
directory 'app/javascripts/scripts/vendor/src'
copy_file 'app/javascripts/scripts/vendor/admin.js'
copy_file 'app/views/alchemy/essences/_richmedia_essence_editor.html.erb'
copy_file 'app/views/alchemy/pages/_meta_data.html.erb', force: true
template 'app/views/layouts/application.html.erb.tt', force: true
copy_file 'config/locales/alchemy.de.yml', force: true
copy_file 'config/locales/devise.de.yml'
copy_file 'lib/tasks/alchemy.rake'
directory 'vendor/assets/javascripts/alchemy_i18n'
directory 'vendor/assets/javascripts/flatpickr'
directory 'vendor/assets/javascripts/tinymce'
copy_file 'vendor/assets/javascripts/alchemy/admin/all.js', force: true

remove_file 'app/controllers/home_controller.rb'
remove_file 'app/views/home/index.html.haml'
FileUtils.rm_r File.expand_path('app/views/home', destination_root)

run_with_clean_bundler_env 'bundle exec rake db:migrate db:seed'
