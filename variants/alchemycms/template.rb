source_paths.unshift(File.dirname(__FILE__))

apply 'Gemfile.rb'
copy_file 'app/views/alchemy/pages/_meta_data.html.haml', force: true
template 'app/views/layouts/application.html.haml.tt', force: true
template 'app/views/shared/_navbar.html.haml.tt', force: true
copy_file 'config/locales/alchemy.de.yml', force: true
apply 'config/deploy.rb' if apply_capistrano?
copy_file 'config/sitemap.rb', force: true
template 'config/critical_path_css.yml.tt', force: true
directory 'vendor/assets/javascripts/alchemy_i18n'
directory 'vendor/assets/javascripts/tinymce'
copy_file 'vendor/assets/javascripts/alchemy/admin/all.js', force: true