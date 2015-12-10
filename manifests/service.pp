class docker::service {
  service { 'docker' :
    ensure      => $docker::present,
    hasstatus   => true,
    hasrestart  => true,
    require     => Package['docker-engine'],
  }
}
