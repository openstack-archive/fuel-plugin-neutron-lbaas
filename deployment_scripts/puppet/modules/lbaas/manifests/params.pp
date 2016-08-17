#Class lbaas::params
class lbaas::params {
  $neutron_conf_file         = '/etc/neutron/neutron.conf'
  $lbaas_conf_file           = '/etc/neutron/lbaas_agent.ini'
  $lbaas_package_name        = 'neutron-lbaasv2-agent'
  $lbaas_service_name        = 'neutron-lbaasv2-agent'
  $lbaas_service_plugin_name = 'neutron_lbaas.services.loadbalancer.plugin.LoadBalancerPluginv2'
  $lbaas_service_provider    = 'LOADBALANCERV2:Haproxy:neutron_lbaas.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver:default'

}
