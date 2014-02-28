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
    $mco_service = 'pe-mcollective'
  }
  else {
    $mco_dir = $::operatingsystem ? {
      /(?i:Debian|Ubuntu|Mint)/ => '/usr/share/mcollective/plugins',
      default                   => '/usr/libexec/mcollective',
    }
    $mco_service = 'mcollective'
  }

}