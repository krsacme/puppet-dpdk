#
# Configure OVS to use DPDK
#
# === Parameters
#
# [*package_ensure*]
#   (Optional) State of the openvswitch package
#   Defaults to 'present'.
#
# [*core_list*]
# (required) The list of cores to be used by the DPDK Poll Mode Driver
#
# [*memory_channels*]
# (required) The number of memory channels to use
#
# [*socket_mem*]
# (required) Set the memory to be allocated on each socket
#
class dpdk::config (
  $package_ensure = 'present',
  $core_list,
  $memory_channels,
  $socket_mem,
) {

  include ::dpdk::params

  package { $::dpdk::params::ovs_package_name:
    ensure => $package_ensure,
    allow_virtual => true,
    before => Service['openvswitch'],
  }

  # Set DPDK_OPTIONS to openvswitch
  $options = "DPDK_OPTIONS = \"-l ${core_list} -n ${memory_channels} --socket-mem ${socket_mem}\""

  file_line { 'dpdk_options':
    path  => '/etc/sysconfig/openvswitch',
    match => '^DPDK_OPTIONS.*',
    line  => $options,
    require => Package[$::dpdk::params::ovs_package_name],
    before => Service['openvswitch']
  }

  case $::osfamily {
    'Redhat': {
      service { 'openvswitch':
        ensure => true,
        enable => true,
        name   => $::dpdk::params::ovs_service_name,
      }
    }
    default: {
      fail( "${::osfamily} not yet supported by puppet-dpdk")
    }
  }

}
