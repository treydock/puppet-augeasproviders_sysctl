# == Class: sysctl
#
# Full description of class sysctl here.
#
# === Parameters
#
# [*package_name*]
#   String.  Name of package that provides the sysctl command.
#   Default: OS dependent
#
# [*config_package_name*]
#   String.  Name of package that provides the sysctl configuration file.
#   Default: OS depedent
#
# [*config_path*]
#   String.  Path to the sysctl configuration file.
#   Default: '/etc/sysctl.conf'
#
# [*values*]
#   Hash or false.  Hash to be passed to define sysctl::value resources.
#   Default: false
#
# === Examples
#
#  class { 'sysctl': }
#
#  # Define systl::value resources
#  class { 'sysctl':
#    values => {
#      'vm.swappiness' => {
#        'value' => '0',
#      },
#    },
#  }
#
# === Authors
#
# Trey Dockendorf <treydock@gmail.com>
#
# === Copyright
#
# Copyright 2013 Trey Dockendorf
#
class sysctl (
  $package_name         = $sysctl::params::package_name,
  $config_package_name  = $sysctl::params::config_package_name,
  $config_path          = $sysctl::params::config_path,
  $values               = $sysctl::params::values
) inherits sysctl::params {

  if $values { validate_hash($values) }

  $sysctl_packages = [$package_name, $config_package_name]

  ensure_packages($sysctl_packages)

  file { '/etc/sysctl.conf':
    ensure  => present,
    path    => $config_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  if $values and !empty($values) {
    $defaults = {
      'ensure'  => 'present',
      'target'  => $config_path,
      'apply'   => true,
    }
    create_resources(sysctl, $values, $defaults)
  }

}
