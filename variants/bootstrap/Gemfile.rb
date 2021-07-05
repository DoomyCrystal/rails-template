insert_into_file 'Gemfile', :after => /gem 'bootsnap'.*\n/ do
  <<-GEMS.strip_heredoc
    gem "bootstrap_form", git: "https://github.com/bootstrap-ruby/bootstrap_form.git", branch: "bootstrap-5"
  GEMS
end
