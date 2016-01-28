chef_ingredient "chef-server" do
  config <<-EOS
api_fqdn "chef.example.com"
EOS
  action :upgrade
  version :latest
end

ingredient_config "chef-server" do
  notifies :reconfigure, "chef_ingredient[chef-server]", :immediately
end

%w( manage push-server reporting ).each do |addon|
  chef_ingredient addon do
    action :upgrade
    version :latest
    notifies :reconfigure, "chef_ingredient[#{addon}]"
  end
end
