prepend_to_file "app/assets/stylesheets/application.scss" do
  <<-SCSS.strip_heredoc
    //= require font-awesome
    //= require rails_bootstrap_forms
    //= require ./bootstrap
  SCSS
end
