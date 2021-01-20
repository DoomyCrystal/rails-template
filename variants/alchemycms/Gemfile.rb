insert_into_file 'Gemfile', before: /gem 'bootsnap'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', '~> 5.1.1'
    gem 'alchemy-devise', '~> 5.1.0'
    gem 'alchemy-richmedia-essences', '~> 2.3.0'
  GEMS
end
