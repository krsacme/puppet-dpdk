#
# Configure OVS to use DPDK
#
# === Parameters
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
  $core_list,
  $memory_channels,
  $socket_mem,
) {

  $options = "-l ${core_list} -n ${memory_channels} --socket-mem ${socket_mem}"
  notify {"KRS print in dpdk:config file with param \$options = ${options} passed": }
  dpdk_config {
    'DPDK_OPTIONS': value => $options
  }
}
