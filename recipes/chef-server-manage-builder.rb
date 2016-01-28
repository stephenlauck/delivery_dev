execute "scp -i /root/.ssh/insecure_private_key -o StrictHostKeyChecking=no -r root@chef.example.com:/tmp/example-validator.pem /etc/chef/example-validator.pem"

# copy delivery cert to build node trusted certs
execute "scp -i /root/.ssh/insecure_private_key -o StrictHostKeyChecking=no -r root@delivery.example.com:/var/opt/delivery/nginx/ca/delivery.example.com.crt /etc/chef/trusted_certs/delivery.example.com.crt"


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
    "delivery_build": {
        "trusted_certs": {
            "delivery server cert": "/etc/chef/trusted_certs/delivery.example.com.crt"
        }
    },
    "run_list": [
        "recipe[delivery_build::default]"
    ]
}
  EOF
end

execute 'cp /etc/delivery/builder_key /var/opt/delivery/workspace/etc'

execute 'cp /etc/delivery/delivery.pem /var/opt/delivery/workspace/etc'

execute 'cp /etc/delivery/builder_key /var/opt/delivery/workspace/.chef'

execute 'cp /etc/delivery/delivery.pem /var/opt/delivery/workspace/.chef'

execute 'knife ssl fetch -c /etc/chef/client.rb'

execute '/opt/chef/bin/chef-client -j /etc/chef/dna.json'
