insert_into_file 'Gemfile', after: /gem 'bcrypt'.*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', github: 'AlchemyCMS/alchemy_cms', branch: '4.3-stable'
    gem 'alchemy-richmedia-essences', '~> 2.0.0'
    gem 'sitemap_generator'
  GEMS
end

if apply_alchemycms_devise?
  insert_into_file 'Gemfile', after: /gem 'alchemy_cms'.*\n/ do
    <<-GEMS.strip_heredoc
      gem 'alchemy-devise', github: 'AlchemyCMS/alchemy-devise', branch: '4.3-stable'
    GEMS
  end
end
