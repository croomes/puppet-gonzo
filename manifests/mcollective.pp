# == Class gonzo::mcollective
#
class gonzo::mcollective {

  File {
    owner => root,
    group => root,
    mode  => '0444',
  }

  file { "${gonzo::mco_dir}/mcollective/agent/gonzo.rb":
    ensure => file,
    source => 'puppet:///modules/gonzo/mcollective/gonzo/agent/gonzo.rb',
    notify => Service[$gonzo::mco_service],
  }

  file { "${gonzo::mco_dir}/mcollective/agent/gonzo.ddl":
    ensure => file,
    source => 'puppet:///modules/gonzo/mcollective/gonzo/agent/gonzo.ddl',
    notify => Service[$gonzo::mco_service],
  }

  file { "${gonzo::mco_ssl_dir}/clients/gonzo-public.pem":
    ensure => file,
    source => 'puppet:///modules/gonzo/mcollective/ssl/gonzo-public.pem',
  }

  file { ["/usr/share/gonzo", "/usr/share/gonzo/augeas"]:
    ensure => directory,
  }

}