chef_ingredient "delivery" do
  config <<-EOS
delivery_fqdn "#{node['delivery']['fqdn']}"

delivery['chef_username']    = "delivery"
delivery['chef_private_key'] = "/etc/delivery/delivery.pem"
delivery['chef_server']      = "https://chef.example.com/organizations/example"

delivery['default_search']   = "((recipes:delivery_build OR recipes:delivery_build\\\\\\\\:\\\\\\\\:default) AND chef_environment:_default)"
EOS
  action :upgrade
  version :latest
end

ingredient_config "delivery" do
  notifies :reconfigure, "chef_ingredient[delivery]"
  notifies :run, "execute[create example enterprise]"
end

execute 'create example enterprise' do
  command 'delivery-ctl create-enterprise example --ssh-pub-key-file=/etc/delivery/builder_key.pub > /tmp/example.creds'
  not_if "delivery-ctl list-enterprises --ssh-pub-key-file=/etc/delivery/builder_key.pub | grep -w example"
  action :nothing
end
