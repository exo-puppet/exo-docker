class docker::config {
  file { "${docker::data_directory}" :
    ensure    => $docker::present ? {
      true    => directory,
      default => absent
    },
    owner     => root,
    group     => root,
  } ->
  file_line {'docker_data_dir' :
    ensure    => $docker::present ? {
      true    => present,
      default => absent
    },
    path      => '/etc/default/docker',
    line      => "DOCKER_OPTS=\"\$DOCKER_OPTS -g ${docker::data_directory}\"",
    notify    => Service["docker"],
  }
}
