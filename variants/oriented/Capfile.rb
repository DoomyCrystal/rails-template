insert_into_file 'Capfile', :after => /require "capistrano\/mb".*\n/ do
  <<-REQUIRES.strip_heredoc
    require "capistrano/rbenv"
    require "capistrano/passenger"
  REQUIRES
end
