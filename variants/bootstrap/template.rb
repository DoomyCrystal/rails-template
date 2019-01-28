source_paths.unshift(File.dirname(__FILE__))

apply 'Gemfile.rb'
apply 'app/assets/stylesheets/application.scss.rb'
copy_file 'app/assets/stylesheets/bootstrap-custom.scss'
copy_file 'app/assets/javascripts/application.js', force: true
copy_file 'app/assets/stylesheets/globals/_all.scss', force: true
copy_file 'app/assets/stylesheets/globals/_animations.scss', force: true
copy_file 'app/assets/stylesheets/globals/_functions.scss', force: true
copy_file 'app/assets/stylesheets/globals/_mixins.scss', force: true
copy_file 'app/assets/stylesheets/globals/_variables.scss', force: true
template 'app/views/layouts/application.html.haml.tt', force: true
template 'app/views/shared/_footer.html.haml.tt'
template 'app/views/shared/_navbar.html.haml.tt'
copy_file 'app/helpers/bootstrap_helper.rb'
copy_file 'lib/templates/haml/controller/view.html.haml'
copy_file 'lib/templates/haml/scaffold/_form.html.haml'
copy_file 'lib/templates/haml/scaffold/edit.html.haml'
copy_file 'lib/templates/haml/scaffold/index.html.haml'
copy_file 'lib/templates/haml/scaffold/new.html.haml'
copy_file 'lib/templates/haml/scaffold/show.html.haml'
directory 'public/fonts'
copy_file 'vendor/assets/stylesheets/fontawesome-all.css', force: true