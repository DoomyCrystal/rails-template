insert_into_file 'Gemfile', :after => /gem 'bcrypt'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'bootstrap_form', '>= 4.2.0'
    gem 'bootstrap', '~> 4.4.1'
  GEMS
end
