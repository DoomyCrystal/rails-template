insert_into_file 'Gemfile', before: /gem 'bootsnap'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', '~> 4.5.0'
    gem 'alchemy-devise', '~> 4.4.0'
    gem 'alchemy-richmedia-essences', '~> 2.0.0'
  GEMS
end
