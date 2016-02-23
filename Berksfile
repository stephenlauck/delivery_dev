source 'https://supermarket.chef.io'

metadata

cookbook 'chef-ingredient', git: 'https://github.com/chef-cookbooks/chef-ingredient.git'
cookbook 'chef-server-ctl', git: 'https://github.com/stephenlauck/chef-server-ctl.git'
cookbook 'delivery_build', git: 'https://github.com/chef-cookbooks/delivery_build.git'
cookbook 'delivery-base', git: 'https://github.com/chef-cookbooks/delivery-base.git'

# HA
cookbook 'lsyncd', git: 'https://github.com/jonsmorrow/chef-lsyncd.git'

group :development do
  cookbook 'omnibus', "~> 3.0.0"
  cookbook 'omnibus-delivery', git: 'git@github.com:chef/delivery.git', rel: 'omnibus/cookbooks/omnibus-delivery'
end
