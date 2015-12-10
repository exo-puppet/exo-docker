class docker::params {
  case $::operatingsystem {
    /(Ubuntu)/ : {
      $distribution = 'ubuntu'
    }
    default : {
      fail("Operating system not yet supported ${::operatingsystem}")
    }
  }

  $repository_selector = "${distribution}-${::lsbdistcodename}"
}
