insert_into_file "Gemfile", :after => /gem "bcrypt".*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', github: 'AlchemyCMS/alchemy_cms', branch: '3.2-stable'
    gem 'alchemy-devise', github: 'AlchemyCMS/alchemy-devise', branch: '3.2-stable'
  GEMS
end
