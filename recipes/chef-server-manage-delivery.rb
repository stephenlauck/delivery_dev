directory '/etc/chef' do
  mode 0755
  recursive true
end

execute "scp -i /root/.ssh/insecure_private_key -o StrictHostKeyChecking=no -r root@chef.example.com:/tmp/example-validator.pem /etc/chef/example-validator.pem"

file '/etc/chef/client.rb' do
  content <<-EOF
log_level                :info
log_location             STDOUT
validation_client_name   "example-validator"
validation_key           "/etc/chef/example-validator.pem"
chef_server_url          "https://chef.example.com/organizations/example"
encrypted_data_bag_secret "/tmp/kitchen/encrypted_data_bag_secret"
EOF
end

file '/etc/chef/dna.json' do
  content <<-EOF
{
    "delivery": {
        "fqdn": "#{node['delivery']['fqdn']}",
        "chef_server": "https://chef.example.com/organizations/example",
        "nodes": ["33.33.33.11","33.33.33.13"]
    },
    "run_list": [
        "recipe[delivery_dev::hostsfile]",
        "recipe[delivery_dev::delivery]",
        "recipe[delivery_dev::delivery_ha]"
    ],
    "vagrant": {
      "ipaddress": "#{node['vagrant']['ipaddress']}"
    }
}
  EOF
end

execute 'knife ssl fetch -c /etc/chef/client.rb'

execute 'chef-client -j /etc/chef/dna.json'
