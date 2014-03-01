# == Class gonzo::server
#
class gonzo::server (
#     $repo       = 'git://github.com/croomes/gonzo.git',
#     $target_dir = '/opt/gonzo',
#     $rails_env  = 'development',
#     $exec_path  = $::path,
  ) {

  include gonzo

# DON'T USE:  Need to package a more recent version of CouchDB first, the
# rpm from epel (couchdb-1.0.4-2.el6.x86_64) doesn't support CORS.
# 
#   vcsrepo { $target_dir:
#     ensure   => present,
#     provider => git,
#     source   => $repo,
#     notify   => [Exec['gonzo_bundle_install'], Exec['gonzo_db_migrate']],
#   }

#   exec { 'gonzo_bundle_install':
#     command   => 'bundle install',
#     path      => $exec_path,
#     cwd       => $target_dir,
#     logoutput => true,
#     # require => File['/usr/bin/pg_config'],
#   }

#   exec { 'gonzo_db_migrate': 
#     command   => "${target_dir}/bin/rake db:migrate",
#     path      => $exec_path,
#     cwd       => $target_dir,
#     environment => "RAILS_ENV=${rails_env}",
#     logoutput => true, 
#     require   => Exec['gonzo_bundle_install'],    
#   }

#   exec { 'gonzo_server': 
#     command   => "${target_dir}/bin/rails server -d",
#     path      => $exec_path,
#     cwd       => $target_dir,
#     environment => "RAILS_ENV=${rails_env}",
#     logoutput => true,
#     creates   => "${target_dir}/tmp/pids/server.pid",
#     require   => Exec['gonzo_db_migrate'],    
#   }
  
}