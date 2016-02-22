# set up shared delivery keys so the two delivery servers can rsync
directory '/opt/delivery/embedded/.ssh' do
  action :create
  owner 'delivery'
  group 'delivery'
  mode '0700'
end

cookbook_file '/opt/delivery/embedded/.ssh/insecure_private_key' do
  action :create
  owner 'delivery'
  group 'delivery'
  mode '0600'
  source 'insecure_private_key'
end

cookbook_file '/opt/delivery/embedded/.ssh/authorized_keys' do
  action :create
  owner 'delivery'
  group 'delivery'
  mode '0600'
  source 'insecure_public_key'
end

package "rsync"

if node['delivery']['fqdn'] == 'delivery-primary.example.com'
  # Create replication user.
  execute "/opt/delivery/embedded/bin/psql -c \"CREATE ROLE replication WITH REPLICATION PASSWORD 'password' LOGIN\" -d delivery chef-pgsql" do
    not_if "/opt/delivery/embedded/bin/psql -c \"SELECT 1 FROM pg_roles WHERE rolname='replication'\" -d delivery replication"
  end

  #Lay down primary config
  template "/var/opt/delivery/postgresql/9.2/data/postgresql.conf" do
    source "primary_postgresql.conf.erb"
    owner 'chef-pgsql'
    group 'chef-pgsql'
    notifies :run, 'execute[restart_postgres]', :immediately
  end

  template "/var/opt/delivery/postgresql/9.2/data/pg_hba.conf" do
    source "pg_hba.conf.erb"
    owner 'chef-pgsql'
    group 'chef-pgsql'
    notifies :run, 'execute[restart_postgres]', :immediately
  end

  execute "restart_postgres" do
    command "delivery-ctl restart postgresql"
    action :nothing
  end
else
  # Setup postgres.conf config and resolve.conf
  template "/var/opt/delivery/postgresql/9.2/data/postgresql.conf" do
    source "secondary_postgresql.conf.erb"
    owner 'chef-pgsql'
    group 'chef-pgsql'
    notifies :run, 'execute[remove_recovery]', :immediately
  end

  ## Dirty Dirty hack
  execute "remove_recovery" do
    command "rm /var/opt/delivery/postgresql/9.2/data/recovery.conf"
    action :nothing
    only_if do ::File.exist?("/var/opt/delivery/postgresql/9.2/data/recovery.conf") end
  end

  template "/var/opt/delivery/postgresql/9.2/data/recovery.conf" do
    source "recovery.conf.erb"
    owner 'chef-pgsql'
    group 'chef-pgsql'
    notifies :run, 'execute[stop_postgres]', :immediately
  end

  execute "stop_postgres" do
    command "delivery-ctl stop postgresql"
    action :nothing
    notifies :run, 'execute[pg_basebackup]', :immediately
  end

  execute "pg_basebackup" do
    command "/opt/delivery/embedded/bin/pg_basebackup -h 33.33.33.11 -D /var/opt/delivery/postgresql/9.2/data/pg_basebackup -U replication --xlog-method=stream"
    action :nothing
    user 'chef-pgsql'
    notifies :run, 'execute[activate_backup]', :immediately
  end

  execute "activate_backup" do
    command "rsync -av --exclude pg_xlog --exclude postgresql.conf --exclude postgresql.pid /var/opt/delivery/postgresql/9.2/data/pg_basebackup/* /var/opt/delivery/postgresql/9.2/data"
    action :nothing
    notifies :run, 'execute[delete_backup]', :immediately
  end

  execute "delete_backup" do
    command "rm -rf /var/opt/delivery/postgresql/9.2/data/pg_basebackup"
    action :nothing
    notifies :run, 'execute[start_postgres]', :immediately
  end

  execute "start_postgres" do
    command "delivery-ctl start postgresql"
    action :nothing
  end
end
