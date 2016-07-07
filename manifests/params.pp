# Parameters for puppet-dpdk
#
class dpdk::params {

  case $::osfamily {
    'RedHat': {
      $ovs_package_name      = 'openvswitch-dpdk'
      $ovs_service_name      = 'openvswitch'
      $provider              = 'ovs_redhat'
    }
    'Debian': {
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }

  } # Case $::osfamily
}
