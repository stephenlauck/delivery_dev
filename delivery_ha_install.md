* Define what kind of servers (cpu, ram, os, etc) and how many a user should have
* Define any assumptions (ssh access, firewall rules, etc)
* Should give instructions on how to obtain the installer
* Should give instructions on how to run the installer

#### Delivery Server Minimum Requirements
* 8G RAM
* 4 cpu
* Ubuntu 14.04
* CentOS/RHEL 6.5
* ssh
* root privilege

#### Assumptions
* must have a machine provisioned with the minimum requirements, ssh access and root privileges
* must have the delivery installer on the machine locally or be able to download it with a tool like [wget](https://www.gnu.org/software/wget/)
* must have the following ports open

| Port           | Protocol    | Description                                 |
| -------------- |------------ | ------------------------------------------- |
| 10000 - 10003  | TCP | Push Jobs
| 8989           | TCP | Delivery Git (SCM)
| 443            | TCP | HTTP Secure
| 22             | TCP | SSH
| 80             | TCP | HTTP
| 5672           | TCP | Analytics MQ
| 10012 - 10013  | TCP | Analytics Messages/Notifier

#### Download the installer
1. SSH to your delivery machine
2. Download the Delivery installer
  * On the Delivery machine run
    `wget https://downloads.chef.io/DELIVERY_HA_INSTALLER`
  * Alternatively you can download the installer from https://downloads.chef.io/ and copy it to your Delivery machine
3. Install the package
  * CentOS/RHLE `sudo rpm -Uvh delivery-ha-0.0.1.rpm`
  * Ubuntu `sudo dpkg -i delivery-ha-0.0.1.deb`
4. The install should output the service URL and credentials
  * go to 'http://DELIVERY_FQDN' and login with your credentials

##### Alternative manual download
1. Download the installer from https://downloads.chef.io/ and copy it to your Delivery machine
