Initial brainstorm of cluster setup after install:

install delivery
  each node is a standalone

search
  find other delivery nodes

election
  pick leader

configuration
  configure leader as primary
  configure rest as standby

----
Ideal Leader election based on k,v store cluster setup

install delivery
  services:
     * delivery
     * delivery-web
     * postgres
     * etcd or other cluster k,v service discovery (maybe chef backend)
     * leader-mngr (comes chef backend)

On startup:
   1. leader-mgr queries etcd (is there a primary) loop every 5 sec
       * no: register self (writes are atomic)
       * yes:
           * and i'm primary re register self
           * not primary: make self standby

    Assumption:
      * TTL causes primary record to decay ~ 10 seconds
      * leader mngr service checks status of self and would remove it's record in etcd if not healthy
      * leader mngr also should check the health check of delivery locally

    Unknowns:
      * how do we discover other etcd instances

    Questions Answered in this model:
      * each standby can know if it's healthy and up to date and avail to become primary
      * no central service needed like chef server

    Added bonus:
      * build nodes could use same leader mngr system and we could deprecate chef-server dependency
           ** To fully remove chef-server dependency we would also need a new dispatch mechanism not dependant on chef-push
