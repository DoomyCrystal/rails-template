source_paths.unshift(File.dirname(__FILE__))

apply "Gemfile.rb"
apply "app/assets/stylesheets/application.css.scss.rb"
copy_file "app/assets/javascripts/bootstrap.js"
copy_file "app/assets/stylesheets/utilities/lib.css.scss"
copy_file "app/assets/stylesheets/utilities/variables.css.scss"
copy_file "app/helpers/navbar_helper.rb"
copy_file "app/views/layouts/application.html.haml", :force => true
template "app/views/shared/_footer.html.haml.tt"
template "app/views/shared/_navbar.html.haml.tt"
copy_file "app/views/shared/_page_header.haml"
copy_file "lib/templates/haml/controller/view.html.haml"
copy_file "lib/templates/haml/scaffold/_form.html.haml"
copy_file "lib/templates/haml/scaffold/edit.html.haml"
copy_file "lib/templates/haml/scaffold/index.html.haml"
copy_file "lib/templates/haml/scaffold/new.html.haml"
copy_file "lib/templates/haml/scaffold/show.html.haml"
copy_file "test/helpers/navbar_helper_test.rb"
