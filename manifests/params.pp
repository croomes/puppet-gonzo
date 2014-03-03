# == Class gonzo::params
#
# This class is meant to be called from gonzo
# It sets variables according to platform
#
class gonzo::params {

  # This is the libdir in the configuration file
  # where plugins are stored
  if $::is_pe == 'true' {
    $mco_dir     = '/opt/puppet/libexec/mcollective'
    $mco_etc_dir = '/etc/puppetlabs/mcollective'
    $mco_ssl_dir = '/etc/puppetlabs/mcollective/ssl'
    $mco_service = 'pe-mcollective'
  }
  else {
    $mco_dir = $::operatingsystem ? {
      /(?i:Debian|Ubuntu|Mint)/ => '/usr/share/mcollective/plugins',
      default                   => '/usr/libexec/mcollective',
    }
    $mco_etc_dir = '/etc/mcollective'
    $mco_ssl_dir = '/etc/mcollective/ssl'
    $mco_service = 'mcollective'
  }

  case $::osfamily {
    /(?i:Debian|Ubuntu|Mint)/: {
      $config    = '/etc/default/gonzo'
    }
    'RedHat': {
      $config    = '/etc/sysconfig/gonzo'
    }
    default: {
      warning("The ${module_name} module is not supported on an ${::osfamily} based system.")
      $config    = '/etc/gonzo'
    }
  }
}