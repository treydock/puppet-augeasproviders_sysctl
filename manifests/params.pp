# == Class: sysctl::augeasproviders_sysctl
#
# The augeasproviders_sysctl configuration settings.
#
# === Authors
#
# Trey Dockendorf <treydock@gmail.com>
#
# === Copyright
#
# Copyright 2013 Trey Dockendorf
#
class augeasproviders_sysctl::params {

  $values = $::augeasproviders_sysctl_values ? {
    undef   => false,
    default => $::augeasproviders_sysctl_values,
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