insert_into_file 'Gemfile', after: /gem 'bcrypt'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', '~> 4.2.0'
    gem 'alchemy-richmedia-essences', '~> 2.0.0'
    gem 'sitemap_generator'
  GEMS
end

if apply_alchemycms_devise?
  insert_into_file 'Gemfile', after: /gem 'alchemy_cms'.*\n/ do
    <<-GEMS.strip_heredoc
      gem 'alchemy-devise', '~> 4.2.1'
    GEMS
  end
end
