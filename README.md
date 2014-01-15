# puppet-augeasproviders_sysctl

[![Build Status](https://travis-ci.org/treydock/puppet-augeasproviders_sysctl.png)](https://travis-ci.org/treydock/puppet-augeasproviders_sysctl)

## Overview

The augeasproviders_sysctl puppet module is a wrapper for the sysctl type provided by the [domcleal/augeasproviders](http://forge.puppetlabs.com/domcleal/augeasproviders) module.

The initial purpose of this module is to allow sysctl resources to be defined from an ENC.

## Reference

### Class: augeasproviders_sysctl

Providing a Hash to the *values* parameter will define sysctl resources.  The example below will add `vm.swappiness = 0` to /etc/sysctl.conf and execute `sysctl -w vm.swappiness=0`.

    class { 'augeasproviders_sysctl':
      values  => {
        'vm.swappiness' => { 'value' => '0' },
      },
    }

The top-scope variable *augeasproviders_sysctl_values* can also be used to define sysctl resources as long as the augeasproviders_sysctl class is included.

    include augeasproviders_sysctl
    
    $augeasproviders_sysctl_values  = {
      'vm.swappiness' => { 'value' => '0' },
    }

## Development

### Testing

Testing requires the following dependencies:

* rake
* bundler

Install gem dependencies

    bundle install

Run unit tests

    bundle exec rake ci

If you have Vagrant >= 1.2.0 installed you can run system tests

    bundle exec rake spec:system

## Further Information

* [augeasproviders](http://augeasproviders.com/)
