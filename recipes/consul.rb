node.default['consul']['config']['bootstrap_expect'] = 2
node.default['consul']['config']['start_join'] = %w{ 33.33.33.10 33.33.33.13 }
node.default['consul']['config']['server'] = true
include_recipe 'consul::default'
