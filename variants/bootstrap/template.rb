source_paths.unshift(File.dirname(__FILE__))

run_with_clean_bundler_env 'yarn add bootstrap popper.js'

apply 'Gemfile.rb'
directory 'app/javascript/scripts'
directory 'app/javascript/scss'
copy_file 'app/javascript/packs/application.js', force: true
