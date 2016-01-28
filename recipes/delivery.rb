directory '/etc/delivery' do
  recursive true
end

execute "scp -i /root/.ssh/insecure_private_key -o StrictHostKeyChecking=no -r root@33.33.33.10:/tmp/delivery.pem /etc/delivery/delivery.pem"

cookbook_file '/etc/delivery/builder_key' do
  action :create
  owner 'root'
  group 'root'
  mode '0600'
  source 'insecure_private_key'
end

cookbook_file '/etc/delivery/builder_key.pub' do
  action :create
  owner 'root'
  group 'root'
  mode '0600'
  source 'insecure_public_key'
end

directory '/var/opt/delivery/license' do
  recursive true
end

cookbook_file '/var/opt/delivery/license/delivery.license' do
  source 'delivery.license'
end

chef_ingredient "delivery" do
  config <<-EOS
delivery_fqdn "delivery.example.com"

delivery['chef_username']    = "delivery"
delivery['chef_private_key'] = "/etc/delivery/delivery.pem"
delivery['chef_server']      = "https://33.33.33.10/organizations/example"

delivery['default_search']   = "((recipes:delivery_build OR recipes:delivery_build\\\\:\\\\:default) AND chef_environment:_default)"
EOS
  action :upgrade
  version :latest
end

ingredient_config "delivery" do
  notifies :reconfigure, "chef_ingredient[delivery]"
  notifies :run, "execute[create test enterprise]"
end

execute 'create test enterprise' do
  command 'delivery-ctl create-enterprise test --ssh-pub-key-file=/etc/delivery/builder_key.pub > /tmp/test.creds'
  not_if "delivery-ctl list-enterprises --ssh-pub-key-file=/etc/delivery/builder_key.pub | grep -w test"
  action :nothing
end
