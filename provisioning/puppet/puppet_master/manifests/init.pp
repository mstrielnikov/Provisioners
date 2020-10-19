# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include master::profile
class profile::puppet::server {
  include master::server
  include master::cert
}
