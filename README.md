# delivery_dev

### Usage

Build a local Delivery cluster using Kitchen for the OS you prefer (ubuntu/centos):

`kitchen converge centos`

### Add to your local machine /etc/hosts
```
33.33.33.12	builder.example.com
33.33.33.10	chef.example.com
33.33.33.11	delivery-primary.example.com
33.33.33.13	delivery-secondary.example.com
```
### chef-server credentials
`delivery/delivery`

### kitchen delivery credentials

`kitchen exec delivery-primary-cent -c 'cat /tmp/example.creds'`

`kitchen exec delivery-secondary-cent -c 'cat /tmp/example.creds'`
