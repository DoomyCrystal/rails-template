source_paths.unshift(File.dirname(__FILE__))

apply 'Gemfile.rb'
directory 'app/javascript/scripts'
directory 'app/javascript/scss'
copy_file 'app/javascript/packs/application.js', force: true
copy_file 'app/views/shared/_purgecss.html.erb'
template 'app/views/shared/_navbar.html.erb.tt'
