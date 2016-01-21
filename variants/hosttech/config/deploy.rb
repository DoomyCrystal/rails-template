hosttech_server = ask_with_default("Hosttech Server?", :blue, "30322.hostserv.eu")
domain_name = ask_with_default("Domain Name?", :blue, "example.com")

append_to_file "config/deploy.rb" do
  <<-VARS.strip_heredoc

    set :hosttech_server, "#{hosttech_server}"
    set :domain_name, "#{domain_name}"
    set :mb_privileged_user, "administrator"
  VARS
end