source_paths.unshift(File.dirname(__FILE__))

apply "Gemfile.rb"
apply "app/assets/stylesheets/application.scss.rb"
copy_file "app/assets/stylesheets/bootstrap.scss"
copy_file "app/assets/javascripts/bootstrap.js"
copy_file "app/assets/stylesheets/components/block-grid.scss"
copy_file "app/assets/stylesheets/globals/_variables.scss", force: true
copy_file "app/helpers/navbar_helper.rb"
template "app/views/layouts/application.html.haml.tt", :force => true
template "app/views/shared/_footer.html.haml.tt"
template "app/views/shared/_navbar.html.haml.tt"
copy_file "app/views/shared/_page_header.haml"
copy_file "app/views/shared/_all_elements.html.haml"
copy_file "lib/templates/haml/controller/view.html.haml"
copy_file "lib/templates/haml/scaffold/_form.html.haml"
copy_file "lib/templates/haml/scaffold/edit.html.haml"
copy_file "lib/templates/haml/scaffold/index.html.haml"
copy_file "lib/templates/haml/scaffold/new.html.haml"
copy_file "lib/templates/haml/scaffold/show.html.haml"
