insert_into_file 'Gemfile', before: /gem 'bootsnap'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', '~> 6.0.0.pre.rc1'
    gem 'alchemy-devise', '~> 5.1.0'
    gem 'gutentag', '2.5.4'
  GEMS
end
