# == Class: sysctl::params
#
# The sysctl configuration settings.
#
# === Variables
#
# [*sysctl_values*]
#   Hash used to define sysctl::value resources.
#
# === Authors
#
# Trey Dockendorf <treydock@gmail.com>
#
# === Copyright
#
# Copyright 2013 Trey Dockendorf
#
class sysctl::params {

  $values = $::sysctl_values ? {
    undef   => false,
    default => $::sysctl_values,
  }

  case $::osfamily {
    'RedHat': {
      $package_name         = 'procps'
      $config_package_name  = 'initscripts'
      $config_path          = '/etc/sysctl.conf'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}