class docker (
  $present        = true,
  $data_directory = undef,
) {
  include docker::params
  include docker::packages
  include docker::service
  include docker::config
}
