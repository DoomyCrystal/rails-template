source_paths.unshift(File.dirname(__FILE__))

apply 'Gemfile.rb'
directory 'app/javascript/scripts'
directory 'app/javascript/scss'
template 'app/views/shared/_navbar.html.erb.tt'
