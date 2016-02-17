
hostsfile_entry '33.33.33.10' do
  hostname  'chef.example.com'
  unique    true
end

hostsfile_entry '33.33.33.11' do
  hostname  'delivery-primary.example.com'
  unique    true
end

hostsfile_entry '33.33.33.13' do
  hostname  'delivery-secondary.example.com'
  unique    true
end

hostsfile_entry '33.33.33.12' do
  hostname  'builder.example.com'
  unique    true
end
