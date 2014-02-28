# == Class gonzo::install
#
class gonzo::install {
  
  # include gonzo

  File {
    owner   => root,
    group   => root,
    mode    => '0444',
  }

  file { "${gonzo::mco_dir}/mcollective/agent/gonzo.rb":
    ensure  => file,
    source  => 'puppet:///modules/gonzo/mcollective/gonzo/agent/gonzo.rb',
    notify  => Service[$gonzo::mco_service],
  }

  file { "${gonzo::mco_dir}/mcollective/agent/gonzo.ddl":
    ensure  => file,
    source  => 'puppet:///modules/gonzo/mcollective/gonzo/agent/gonzo.ddl',
    notify  => Service[$gonzo::mco_service],
  }

}