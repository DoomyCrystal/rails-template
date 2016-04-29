namespace :hosting do

  desc 'Prepare oriented.net Hosting for deployment.'
  task :setup do
    on roles(:app) do |host, user|
      info 'Setup ssh-keys'
      unless test("sudo [ -f /home/#{user}/.ssh/authorized_keys ]")
        execute :sudo, "mkdir", "-p", "/home/#{user}/.ssh"
        execute :sudo, "cp", "~#{root}/.ssh/authorized_keys",
                "/home/#{user}/.ssh"
        execute :sudo, "chown", "-R", "#{user}:#{user}", "/home/#{user}/.ssh"
        execute :sudo, "chmod", "600", "/home/#{user}/.ssh/authorized_keys"
      end

      info 'Stopping passenger'
      execute 'cd current'
      execute 'passenger stop --pid-file passenger.pid'
      info 'Deleting test-app'
      execute :cd, '..'
      execute :rm, '-rf', './current'

      info 'Done! Now you can deploy your app and start passenger once with: " passenger start --socket tmp/sockets/passenger.socket -e production -d"'
    end
  end

end