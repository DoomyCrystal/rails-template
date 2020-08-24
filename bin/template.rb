copy_file 'bin/setup', force: true
copy_file 'bin/server'
copy_file 'bin/yarn'
chmod 'bin/setup', '+x'
chmod 'bin/server', '+x'
chmod 'bin/yarn', '+x'
