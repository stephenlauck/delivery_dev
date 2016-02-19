default['delivery']['fqdn'] = "delivery.example.com"

## Setting this to true so lysnc d will retry unitl secondary comes up.
include_attribute "lsyncd"
default['lsyncd']['insist'] = true
