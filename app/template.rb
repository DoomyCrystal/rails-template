apply "app/assets/javascripts/application.js.rb"
copy_file "app/assets/stylesheets/components/browse-happy.css.scss"
copy_file "app/assets/stylesheets/components/svg.css.scss"
copy_file "app/assets/stylesheets/globals/_all.scss"
copy_file "app/assets/stylesheets/globals/_functions.scss"
copy_file "app/assets/stylesheets/globals/_mixins.scss"
copy_file "app/assets/stylesheets/globals/_variables.scss"
copy_file "app/assets/stylesheets/application.css.scss"
copy_file "app/assets/stylesheets/base.css.scss"
copy_file "app/assets/stylesheets/layout.css.scss"
remove_file "app/assets/stylesheets/application.css"

insert_into_file "app/controllers/application_controller.rb",
                 :after => /protect_from_forgery.*\n/ do
  "  ensure_security_headers\n"
end

copy_file "app/controllers/home_controller.rb"
copy_file "app/helpers/javascript_helper.rb"
copy_file "app/helpers/layout_helper.rb"
remove_file "app/views/layouts/application.html.erb"
template "app/views/layouts/application.html.haml.tt", force: true
copy_file "app/views/shared/_flash.html.haml"
copy_file "app/views/home/index.html.haml"