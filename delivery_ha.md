What are the things we need to sync?

* -postgresql
* -git repos / local storage directory
* keys
* in progress state in Delivery app

Strategies
1. use backups
  * will grow linearly and is already >60s with a backup of 1G
2. explore shared filesystem like Ceph



Flow of data:


### kitchen delivery credentials

`kitchen exec delivery-primary-cent -c 'cat /tmp/example.creds'`

`kitchen exec delivery-secondary-cent -c 'cat /tmp/example.creds'`
