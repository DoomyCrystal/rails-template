source_paths.unshift(File.dirname(__FILE__))

copy_file "lib/capistrano/mb/templates/nginx_unicorn.erb", force: true
copy_file "lib/capistrano/tasks/hosting.rake", force: true
copy_file "lib/capistrano/mb/tasks/nginx.rake", force: true
apply "config/deploy.rb"