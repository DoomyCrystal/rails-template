insert_into_file 'Gemfile', before: /gem 'bootsnap'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', '~> 6.0.0.b1'
    gem 'alchemy-devise', '~> 5.1.0'
  GEMS
end
