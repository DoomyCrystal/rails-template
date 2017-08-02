append_to_file 'config/deploy.rb' do
  <<-VARS.strip_heredoc

    fetch(:mb_aptitude_packages)["imagemagick"] = :all
    set :linked_dirs, fetch(:linked_dirs, []).push('uploads/pictures', 'uploads/attachments', 'public/pictures')

    namespace :deploy do
      after :restart, :clear_cache do
        on roles(:web) do
          within release_path do
            execute :rake, 'tmp:clear'
            execute :rake, 'sitemap:create'
          end
        end
      end

      after :finishing, 'deploy:restart'
    end
  VARS
end