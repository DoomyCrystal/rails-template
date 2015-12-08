desc 'Establish maintenance on server (show maintenance.html, run aptitude safe-upgrade and restart server)'
task :maintenance do
  invoke 'mb:maintenance:enable'
  invoke 'mb:aptitude:upgrade'
  invoke 'mb:nginx:restart'
  invoke 'mb:unicorn:restart'
  invoke 'mb:maintenance:disable'
end