# Class: splunk::params
#
# This class defines default parameters used by the main module class splunk
#
# == Variables
#
# Refer to splunk class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class splunk::params {

  ### Application related parameters

  $install = 'forwarder'

  $install_source = ''

  $admin_password = 'changeme'

  $forward_server = ''

  $monitor_path = ''
  $monitor_sourcetype = ''

  $template_inputs = ''

  $template_outputs = ''

  $template_server = ''

  $template_web = ''

  $port = '8089'

  $protocol = 'tcp'


  ### General variables that affect module's behaviour
  # They can be set at top scope level or in a ENC

  $my_class = ''
  $source_dir = ''
  $source_dir_purge = false
  $options = ''
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  # They can be set at top scope level or in a ENC

  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
