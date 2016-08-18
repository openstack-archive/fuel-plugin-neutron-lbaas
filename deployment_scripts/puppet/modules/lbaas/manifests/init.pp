#    Copyright 2016 Mirantis, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

class lbaas {
  include lbaas::params

  package { $lbaas::params::lbaas_package_name:
    ensure => present,
  }

  neutron_config {
    'service_providers/service_provider': value => $lbaas::params::lbaas_service_provider;
  }

  ini_subsetting {'enable_lbaas_plugin':
    ensure               => present,
    section              => 'DEFAULT',
    key_val_separator    => '=',
    path                 => $lbaas::params::neutron_conf_file,
    setting              => 'service_plugins',
    subsetting           => $lbaas::params::lbaas_service_plugin_name,
    subsetting_separator => ',',
  }

  lbaas_config {
    'DEFAULT/interface_driver': value => 'openvswitch';
  }

  exec { 'neutron-db-sync':
    command   => 'neutron-db-manage --subproject neutron-lbaas upgrade head',
    path      => '/usr/bin',
    logoutput => on_failure,
    require   => Package[$lbaas::params::lbaas_package_name],
  }

  Neutron_config<||> ~> Service<| tag == 'lbaas-service' |>
  Ini_subsetting<||> ~> Service<| tag == 'lbaas-service' |>
  Lbaas_config<||>   ~> Service<| tag == 'lbaas-service' |>
  
  service { 'neutron-server':
    ensure     => running,
    enable     => true,
    tag        => 'lbaas-service',
    hasstatus  => true,
    hasrestart => true,
    require    => Exec['neutron-db-sync'],
  }

  service { $lbaas::params::lbaas_service_name:
    ensure  => running,
    enable  => true,
    tag     => 'lbaas-service',
    require => Exec['neutron-db-sync'],
  }

}
