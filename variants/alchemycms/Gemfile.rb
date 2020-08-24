insert_into_file 'Gemfile', before: /gem 'bootsnap'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', git: 'https://github.com/AlchemyCMS/alchemy_cms.git', branch: '5.0-stable'
    gem 'alchemy-devise', git: 'https://github.com/AlchemyCMS/alchemy-devise.git', branch: '5.0-stable'
    gem 'alchemy-richmedia-essences', '~> 2.3.0'
  GEMS
end
