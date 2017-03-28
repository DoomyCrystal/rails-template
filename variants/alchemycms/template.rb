source_paths.unshift(File.dirname(__FILE__))

apply "Gemfile.rb"
copy_file "app/views/alchemy/pages/sitemap.xml.haml", force: true
copy_file "app/views/alchemy/pages/_meta_data.html.haml", force: true
copy_file "app/helpers/alchemy_helper.rb", force: true
template "app/views/layouts/application.html.haml.tt", force: true
template "app/views/shared/_navbar.html.haml.tt", force: true
apply "config/deploy.rb"
copy_file "config/sitemap.rb", force: true