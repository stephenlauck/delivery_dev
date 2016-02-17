# delivery_dev

### Usage
Set an environment variable for the path to your Delivery repo if you want to compile the omnibus package locally:

`export DELIVERY_REPO=/home/lemmy/delivery`

Build a local Delivery cluster using Kitchen for the OS you prefer (ubuntu/centos):

`kitchen converge centos`

```
33.33.33.10 chef.example.com
33.33.33.11 delivery.example.com
33.33.33.12 build.example.com
```
