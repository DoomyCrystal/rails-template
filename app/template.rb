copy_file 'app/controllers/errors_controller.rb'
copy_file 'app/controllers/home_controller.rb'
copy_file 'app/controllers/service_worker_controller.rb'
copy_file 'app/helpers/layout_helper.rb'
template 'app/views/layouts/application.html.erb.tt', force: true
copy_file 'app/views/errors/internal_server_error.html.erb'
copy_file 'app/views/errors/not_found.html.erb'
copy_file 'app/views/home/index.html.erb'
copy_file 'app/views/service_worker/service_worker.js.erb'
copy_file 'app/views/service_worker/manifest.json.erb'

