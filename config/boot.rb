insert_into_file 'config/boot.rb',
                 %Q(require 'bootsnap/setup unless ENV["DISABLE_BOOTSNAP"]'\n),
                 after: %r{bundler/setup.*$\n}