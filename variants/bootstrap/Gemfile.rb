insert_into_file 'Gemfile', :after => /gem 'bcrypt'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'bootstrap_form', '>= 4.0.0.alpha1'
    gem 'bootstrap', '~> 4.2.1'
  GEMS
end
