copy_file 'app/assets/stylesheets/components/browse-happy.scss'
copy_file 'app/assets/stylesheets/components/svg.scss'
copy_file 'app/assets/stylesheets/globals/_all.scss'
copy_file 'app/assets/stylesheets/globals/_functions.scss'
copy_file 'app/assets/stylesheets/globals/_mixins.scss'
copy_file 'app/assets/stylesheets/globals/_variables.scss'
copy_file 'app/assets/stylesheets/application.scss'
copy_file 'app/assets/stylesheets/base.scss'
copy_file 'app/assets/stylesheets/layout.scss'
remove_file 'app/assets/stylesheets/application.css'

copy_file 'app/assets/javascripts/serviceworker.js.erb'
copy_file 'app/assets/javascripts/serviceworker-companion.js'

copy_file 'app/controllers/home_controller.rb'
copy_file 'app/helpers/layout_helper.rb'
remove_file 'app/views/layouts/application.html.erb'
template 'app/views/layouts/application.html.haml.tt', force: true
copy_file 'app/views/shared/_flash.html.haml'
copy_file 'app/views/shared/_critical_path.html.haml'
copy_file 'app/views/home/index.html.haml'

remove_dir 'app/jobs'
empty_directory_with_keep_file 'app/workers'