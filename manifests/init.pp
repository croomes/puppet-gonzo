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
  $tier        = $::tier,
  $release     = $::release,
  $config      = $gonzo::params::config,
  $mco_dir     = $gonzo::params::mco_dir,
  $mco_etc_dir = $gonzo::params::mco_etc_dir,
  $mco_ssl_dir = $gonzo::params::mco_ssl_dir,
  $mco_service = $gonzo::params::mco_service,
) inherits gonzo::params {

  # validate parameters here
  validate_absolute_path($mco_dir)
  validate_absolute_path($mco_etc_dir)
  validate_absolute_path($mco_ssl_dir)

  class { 'gonzo::mcollective': } ->
  class { 'gonzo::config': } ->
  Class['gonzo']
}