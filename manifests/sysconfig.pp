# == Class gonzo::sysconfig
#
# This class is called from gonzo
#
class gonzo::sysconfig inherits gonzo {

  file { '/etc/sysconfig/gonzo':
    ensure  => file,
    content => template('gonzo/sysconfig.erb'),
  }

}