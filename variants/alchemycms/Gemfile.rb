insert_into_file "Gemfile", :after => /gem "bcrypt".*\n/ do
  <<-GEMS.strip_heredoc
    gem "alchemy_cms", "~> 3.2.0"
    gem "alchemy-devise", "~> 3.2.0"
  GEMS
end
