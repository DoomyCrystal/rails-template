source_paths.unshift(File.dirname(__FILE__))

run_with_clean_bundler_env 'yarn add tailwindcss@npm:@tailwindcss/postcss7-compat postcss@7 autoprefixer@9'

directory 'app/javascript/scripts'
directory 'app/javascript/stylesheets'
copy_file 'app/javascript/packs/application.js', force: true
copy_file 'postcss.config.js', force: true
