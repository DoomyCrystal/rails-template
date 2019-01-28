prepend_to_file 'app/assets/stylesheets/application.scss' do
  <<-SCSS.strip_heredoc
    //= require fontawesome-all
    //= require rails_bootstrap_forms
    //= require ./bootstrap-custom
  SCSS
end
