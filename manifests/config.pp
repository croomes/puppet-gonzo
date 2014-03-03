# == Class gonzo::config
#
# This class is called from gonzo
#
class gonzo::config inherits gonzo {

  file { $gonzo::config:
    ensure  => file,
    content => template('gonzo/config.erb'),
  }

}