execute 'chef-server-ctl restart' do
  action :nothing
end

cache_path = Chef::Config[:file_cache_path]

file "#{cache_path}/chef-server-core.restart" do
  action :create
  notifies :run, 'execute[chef-server-ctl restart]', :immediately
  not_if do ::File.exists?("#{cache_path}/chef-server-core.restart") end
end

chef_server_user 'delivery' do
  firstname 'Example'
  lastname 'User'
  email 'delivery@example.com'
  password username
  private_key_path '/tmp/delivery.pem'
  action :create
end

chef_server_org 'example' do
  org_long_name 'Example Organization'
  org_private_key_path '/tmp/example-validator.pem'
  action :create
end

chef_server_org 'example' do
  admins %w( delivery )
  action :add_admin
end
