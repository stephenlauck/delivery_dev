# delivery_dev

TODO: Enter the cookbook description here.

* build, sync converge could be streamlined
* installing a package via dpkg is faster than rebuild/converging
* no clear full converge commands for cluster
* upgrade should be default in dev env for all packages so if package changes, it's upgraded with no code change 
* should be able to run omnibus build vm and dev cluster at same time no problem re ports, size, and memory
* all commands should be same for suspend/resume in Makefiles for omnibus and infra
* dev install should be a public cookbook, not included in the delivery repo
* omnibus and delivery on same giant VM for compiling and syncing


ideas
* make omnibus and infra same


chef-server
* chef-ingredient + config
delivery-server
* chef-ingredient + config
builder
* https://github.com/chef-cookbooks/delivery_build + config

* kitchen + simple scp code to orchestrate
* remove chef-provisioning