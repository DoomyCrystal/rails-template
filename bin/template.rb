copy_file 'bin/setup', force: true
copy_file 'bin/server'
chmod 'bin/setup', '+x'
chmod 'bin/server', '+x'
