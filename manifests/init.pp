# == Class: gonzo
#
# Full description of class gonzo here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class gonzo (
  $release     = $::environment,
  $mco_dir     = $gonzo::params::mco_dir,
  $mco_service = $gonzo::params::mco_service,
) inherits gonzo::params {

  # validate parameters here
  validate_absolute_path($mco_dir)

  class { 'gonzo::install': } ->
  class { 'gonzo::sysconfig': } ->
  Class['gonzo']
}