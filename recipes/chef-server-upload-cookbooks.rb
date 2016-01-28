file '/tmp/config.rb' do
  content <<-EOF
log_level                :info
log_location             STDOUT
node_name                "delivery"
client_key               "/tmp/delivery.pem"
validation_client_name   "example-validator"
validation_key           "/tmp/example-validator.pem"
chef_server_url          "https://chef.example.com/organizations/example"
cookbook_path            ["/tmp/kitchen/cookbooks"]
EOF
end

execute 'knife ssl fetch -c /tmp/config.rb'

# execute 'knife upload cookbooks data_bags --chef-repo-path . -c ../config.rb' do
execute 'knife cookbook upload -a cookbooks -c ../config.rb && knife upload data_bags --chef-repo-path . -c ../config.rb' do
  cwd '/tmp/kitchen'
end
