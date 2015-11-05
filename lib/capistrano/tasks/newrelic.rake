mb_recipe :newrelic do
  during :provision, %w(
    newrelic_yml
  )
end

namespace :mb do
  namespace :newrelic do
    desc "Generate newrelic.yml"
    task :newrelic_yml do
      on release_roles(:all) do
        template 'newrelic.yml.erb',
            "#{shared_path}/config/newrelic.yml",
            :mode => "600"
      end
    end
  end
end
