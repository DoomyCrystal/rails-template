if apply_capistrano?
  copy_file 'lib/capistrano/tasks/maintenance.rake'
  copy_file 'lib/capistrano/mb/templates/crontab.erb'
  copy_file 'lib/capistrano/mb/templates/nginx_unicorn.erb'
  copy_file 'lib/capistrano/mb/templates/maintenance.html.erb'
end
copy_file 'lib/tasks/auto_annotate_models.rake'
copy_file 'lib/tasks/coverage.rake'
