file "/etc/consul/conf.d/delivery.json" do
  content <<-EOD
  {"service": {"name": "delivery", "tags": ["delivery"], "port": 80,
    "check": {"script": "curl -k https://delivery-primary.example.com/status/version >/dev/null 2>&1", "interval": "10s"}}}
  EOD
end
