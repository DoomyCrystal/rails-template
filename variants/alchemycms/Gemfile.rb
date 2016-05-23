insert_into_file "Gemfile", :after => /gem "bcrypt".*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', '~> 3.3.0'
    gem 'alchemy-devise', github: 'AlchemyCMS/alchemy-devise', tag: 'v3.3.0'
  GEMS
end
