insert_into_file "config/boot.rb",
                 %Q(require "bootsnap/setup"\n),
                 :after => %r{bundler/setup.*$\n}