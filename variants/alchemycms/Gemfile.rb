insert_into_file "Gemfile", :after => /gem "bcrypt".*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', '~> 3.4.0'
    gem 'alchemy-devise', github: 'AlchemyCMS/alchemy-devise', branch: '3.4-stable'
  GEMS
end
