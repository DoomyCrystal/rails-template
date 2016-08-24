insert_into_file "Gemfile", :after => /gem "bcrypt".*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', '~> 3.4.0'
  GEMS
end

if apply_alchemycms_devise?
  insert_into_file "Gemfile", :after => /gem 'alchemy_cms'.*\n/ do
    <<-GEMS.strip_heredoc
      gem 'alchemy-devise', github: 'AlchemyCMS/alchemy-devise', branch: '3.4-stable'
    GEMS
  end
end