Delivery Dev Replication cluster
====
If you run kitchen converge <<platform>> you should get a cluster with a chef server,
2 delivery servers, and a builder. The Delivery servers will be setup with the primary's
postgres doing streaming replication to the secondary's read only data base. Because the
secondary's database is read only it does not support loging in directly (since delivery
does a write of the token on login). Never fear the tokens form the primary are sync'd to
the secondary and there is a work around in the demo steps below to copy this token between
browser sessions.


To test that replication is working:
1. `kitchen exec delivery-primary-cent -c 'cat /tmp/example.creds'`
2. log into the primary (https://delivery-primary.example.com/e/example/#) and create an org and/or
project.
3. Open the developer tools in chrome
4. Open 'Resources' and select 'Local Storage'
5. In another browser window go to the login page of the secondary (https://delivery-secondary.example.com/e/example/#)
6. Open the developer tools in chrome
7. Open 'Resources' and select 'Local Storage'
8. Copy the key 'examplesession' and value from the primary to the secondary browser
9. Refresh the secondary browser and you should land on the dashboard
10. From here you can navigate around and see your org/project etc. Just remember only read ops work.

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
