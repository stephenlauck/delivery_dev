directory '/etc/delivery' do
  recursive true
end

execute "scp -i /root/.ssh/insecure_private_key -o StrictHostKeyChecking=no -r root@chef.example.com:/tmp/delivery.pem /etc/delivery/delivery.pem"

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
