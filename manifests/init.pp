# == Class: augeasproviders_sysctl
#
# Full description of class augeasproviders_sysctl here.
#
# === Parameters
#
# [*package_name*]
#   String.  Name of package that provides the augeasproviders_sysctl command.
#   Default: OS dependent
#
# [*config_package_name*]
#   String.  Name of package that provides the augeasproviders_sysctl configuration file.
#   Default: OS depedent
#
# [*config_path*]
#   String.  Path to the augeasproviders_sysctl configuration file.
#   Default: '/etc/augeasproviders_sysctl.conf'
#
# [*values*]
#   Hash or false.  Hash to be passed to define augeasproviders_sysctl::value resources.
#   Default: false
#
# === Examples
#
#  class { 'augeasproviders_sysctl': }
#
#  # Define systl::value resources
#  class { 'augeasproviders_sysctl':
#    values => {
#      'vm.swappiness' => {
#        'value' => '0',
#      },
#    },
#  }
#
# === Variables
#
# [*augeasproviders_sysctl_values*]
#   Hash used to define sysctl resources.
#
# === Authors
#
# Trey Dockendorf <treydock@gmail.com>
#
# === Copyright
#
# Copyright 2013 Trey Dockendorf
#
class augeasproviders_sysctl (
  $package_name         = $augeasproviders_sysctl::params::package_name,
  $config_package_name  = $augeasproviders_sysctl::params::config_package_name,
  $config_path          = $augeasproviders_sysctl::params::config_path,
  $values               = $augeasproviders_sysctl::params::values
) inherits augeasproviders_sysctl::params {

  if $values { validate_hash($values) }

  $sysctl_defaults = {
    'ensure'  => 'present',
    'target'  => $config_path,
    'apply'   => true,
  }

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
    create_resources(sysctl, $values, $sysctl_defaults)
  }

}
