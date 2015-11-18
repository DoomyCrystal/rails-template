source_paths.unshift(File.dirname(__FILE__))

apply "Gemfile.rb"
copy_file "app/views/alchemy/pages/sitemap.xml.erb", force: true
copy_file "app/helpers/alchemy_helper.rb", force: true
template "app/views/layouts/application.html.haml.tt", force: true
template "app/views/shared/_navbar.html.haml.tt", force: true
template "config/deploy.rb.tt", force: true