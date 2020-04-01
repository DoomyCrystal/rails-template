insert_into_file 'Gemfile', :after => /gem 'bootsnap'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'bootstrap_form', '>= 4.4.0'
    gem 'bootstrap', '~> 4.4.1'
  GEMS
end
