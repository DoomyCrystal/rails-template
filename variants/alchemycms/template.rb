source_paths.unshift(File.dirname(__FILE__))

apply "Gemfile.rb"
template "app/views/layouts/base.html.haml.tt", force: true
template "app/views/shared/_navbar.html.haml.tt", force: true
template "config/deploy.rb.tt", force: true