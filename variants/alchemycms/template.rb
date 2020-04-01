source_paths.unshift(File.dirname(__FILE__))

apply 'Gemfile.rb'
copy_file 'app/views/alchemy/pages/_meta_data.html.erb', force: true
template 'app/views/layouts/application.html.erb.tt', force: true
copy_file 'config/locales/alchemy.de.yml', force: true
directory 'vendor/assets/javascripts/alchemy_i18n'
directory 'vendor/assets/javascripts/flatpickr'
copy_file 'vendor/assets/javascripts/alchemy/admin/all.js', force: true
