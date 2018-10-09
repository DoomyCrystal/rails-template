insert_into_file 'Gemfile', :after => /gem 'bcrypt'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'bootstrap_form', '>= 4.0.0.alpha1'
    gem 'bootstrap', '~> 4.1.3'
  GEMS
end

insert_into_file 'Gemfile', :after => /gem 'dotenv-rails'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'font-awesome-rails'
  GEMS
end
