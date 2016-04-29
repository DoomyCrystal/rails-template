gsub_file 'Gemfile', 'gem "unicorn"', ''
gsub_file 'Gemfile', 'gem "unicorn-worker-killer"', ''

insert_into_file 'Gemfile', :after => /gem "capistrano-rails", :require => false.*\n/ do
  <<-GEMS.strip_heredoc
    gem "capistrano-passenger", :require => false
    gem "capistrano-rbenv", "~> 2.0", :require => false
  GEMS
end