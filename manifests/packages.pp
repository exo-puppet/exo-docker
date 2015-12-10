class docker::packages {
  include apt
  package {'docker.io' :
    ensure      => purged;
  } ->
  exec { 'docker_repo_key' : # the repo key is not compatible with apt:1.7.0 puppet plugin, need to be installed manually
    command => 'apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D',
    unless      => 'apt-key list | grep "Docker Release Tool"'
  } ->
  apt::conf { 'docker' : # to avoid https://github.com/docker/docker/issues/9592
    ensure      => $docker::present ? {
      true    => present,
      default => absent
    },
    content     => 'Acquire::HTTP::Proxy::apt.dockerproject.org "DIRECT";',
  } ->
  apt::source { 'docker':
    ensure      => $docker::present ? {
      true    => present,
      default => absent
    },
    location    => 'https://apt.dockerproject.org/repo',
    repos       => 'main',
    release     => "${docker::params::repository_selector}",
    include_src => false,
  } ->
  package { 'docker-engine' :
    ensure      => $docker::present ? {
      true    => installed,
      default => absent
    },
  }
}
