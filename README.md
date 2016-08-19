LBaaS plugin for fuel
============

Overview
--------
LBaaS (Load-Balancing-as-a-Service) is currently an advanced service of Neutron. It allows for proprietary and open-source load balancing technologies to drive the actual load balancing of requests.

Requirements
------------
- Currently compatible with Mirantis OpenStack 6.0,6.1,9.0


Prerequisites
-------------
- Neutron


Limitations
-----------
- In HA mode rescheduling of LB instances will not work
https://blueprints.launchpad.net/neutron/+spec/lbaas-ha-agent, https://blueprints.launchpad.net/neutron/+spec/lbaas-ha-haproxy
- LBaaS agent floods log when stats socket is not found
https://bugs.launchpad.net/neutron/+bug/1569827
- Dashboard configuration is not available


Installing the plugin
---------------------
- Copy the plugin to the Fuel node:
	scp lbaas-1.0-1.0.3-1.noarch.rpm root@10.20.0.2:~
- Install the plugin:
	fuel plugins --install lbaas-1.0-1.0.3-1.noarch.rpm


Configuring the plugin
----------------------
- Create a new OpenStack environment
- Use neutron for networking setup
- On Settings tab, in Other group, select LBaaS plugin for Neutron
- Add controller, compute etc nodes to the environment


Usage
-----
- http://docs.openstack.org/mitaka/networking-guide/adv-config-lbaas.html#lbaas-v2-operations

