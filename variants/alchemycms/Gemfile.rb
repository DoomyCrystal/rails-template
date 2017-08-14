insert_into_file 'Gemfile', after: /gem "bcrypt".*\n/ do
  <<-GEMS.strip_heredoc
    gem 'alchemy_cms', '~> 3.6.0'
    gem 'alchemy-image_optim', git: 'https://github.com/m43nu/alchemy-image_optim.git'
    gem 'image_optim_pack'
    gem 'sitemap_generator'
  GEMS
end

if apply_alchemycms_devise?
  insert_into_file 'Gemfile', after: /gem 'alchemy_cms'.*\n/ do
    <<-GEMS.strip_heredoc
      gem 'alchemy-devise', '~> 3.5.0'
    GEMS
  end
end