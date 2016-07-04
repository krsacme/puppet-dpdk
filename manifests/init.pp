# == Class: dpdk
#
# Full description of class dpdk here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class dpdk {
  notify {"KRS print":}
  include ::dpdk::params
  include ::dpdk::config

}
