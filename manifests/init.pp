# = Class: splunk
#
# This is the main splunk class
#
#
# == Parameters
#
# Specific class parameters
# [*install*]
#   Splunk install type:
#   - server - For complete installation (seacher, indexer...).
#              Use this on central server
#   - forwarder - TO install only the universal forwarder package
#                 Use this on all the other servers (Default option)
#
# [*install_source*]
#   Complete URL (http://....) of the splunk or splunkforwarder package
#   to install. If not defined you must be able to install these
#   packages via your default provider (apt, yum...) so you should
#   have them in a custom repo
#
# [*admin_password*]
#   Splunk admin password both for the forwarder management and the splunk web
#   interface. Default is "changeme"
#
# [*forward_server*]
#   The central server(s) to forward messages to. MUST be in host:port format
#   If you want to forward to more than one servers, use an array.
#   Example: [ "splunk1.example42.com:9997" , "splunk2.example42.com:9997" ]
#
# [*monitor_path*]
#   The path of files or directories that you want to monitor with Splunk
#   Either on the central server or the forwarders. May be an array.
#   Example: [ "/var/log/tomcat6/catalina.out" , "/var/log/apache2" ]
#
# [*monitor_sourcetype*]
#   The source_type for the logs defined in monitor_path
#   If you need a more granular management of sourcetype for different logs
#   try splunk::input::monitor
#
# [*template_inputs*]
#   A custom template to use for a custom etc/system/local/inputs.conf file
#   The value is used in: content => template($template_inputs),
#   Note that splunk generates autonomously this file, overwrite if you know
#   what you're doing.
#
# [*template_outputs*]
#   A custom template to use for a custom etc/system/local/outputs.conf file
#   The value is used in: content => template($template_outputs),
#   Note that splunk generates autonomously this file and on the forwarder
#   this is populated with the value of forward_server
#
# [*template_server*]
#   A custom template to use for a custom etc/system/local/server.conf file
#   The value is used in: content => template($template_server),
#   Note that splunk generates autonomously this file, overwrite if you know
#   what you're doing.
#
# [*template_web*]
#   A custom template to use for a custom etc/system/local/web.conf file
#   The value is used in: content => template($template_web),
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, splunk class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $splunk_myclass
#
# [*source_dir*]
#   If defined, the whole splunk configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $splunk_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $splunk_source_dir_purge
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $splunk_options
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $splunk_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $splunk_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $splunk_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $splunk_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for splunk checks
#   Can be defined also by the (top scope) variables $splunk_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ip_address
#   Can be defined also by the (top scope) variables $splunk_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $splunk_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $splunk_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $splunk_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for splunk port(s)
#   Can be defined also by the (top scope) variables $splunk_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling splunk. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $splunk_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $splunk_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $splunk_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $splunk_audit_only
#   and $audit_only
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $splunk_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $splunk_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include splunk"
# - Call splunk as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class splunk (
  $install            = params_lookup('install'),
  $install_source     = params_lookup('install_source'),
  $admin_password     = params_lookup('admin_password'),
  $forward_server     = params_lookup('forward_server'),
  $monitor_path       = params_lookup('monitor_path'),
  $monitor_sourcetype = params_lookup('monitor_sourcetype'),
  $template_inputs    = params_lookup('template_inputs'),
  $template_outputs   = params_lookup('template_outputs'),
  $template_server    = params_lookup('template_server'),
  $template_web       = params_lookup('template_web'),
  $my_class           = params_lookup('my_class'),
  $source_dir         = params_lookup('source_dir'),
  $source_dir_purge   = params_lookup('source_dir_purge'),
  $options            = params_lookup('options'),
  $absent             = params_lookup('absent'),
  $disable            = params_lookup('disable'),
  $disableboot        = params_lookup('disableboot'),
  $monitor            = params_lookup( 'monitor' , 'global' ),
  $monitor_tool       = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target     = params_lookup( 'monitor_target' , 'global' ),
  $puppi              = params_lookup( 'puppi' , 'global' ),
  $puppi_helper       = params_lookup( 'puppi_helper' , 'global' ),
  $firewall           = params_lookup( 'firewall' , 'global' ),
  $firewall_tool      = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src       = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst       = params_lookup( 'firewall_dst' , 'global' ),
  $debug              = params_lookup( 'debug' , 'global' ),
  $audit_only         = params_lookup( 'audit_only' , 'global' ),
  $port               = params_lookup('port'),
  $protocol           = params_lookup('protocol')
  ) inherits splunk::params {

  # Module's internal variables
  $basename = $splunk::install ? {
    server    => 'splunk',
    forwarder => 'splunkforwarder',
  }

  $basedir = $splunk::install ? {
    server    => '/opt/splunk',
    forwarder => '/opt/splunkforwarder',
  }

  $package = $splunk::basename
  $service = 'splunk'
  $service_status = true
  $process = 'splunkd'
  $process_args = ''
  $config_dir = "${splunk::basedir}/etc/"
  $config_file_mode = '0644'
  $config_file_owner = 'splunk'
  $config_file_group = 'splunk'
  $pid_file = "${splunk::basedir}/var/run/splunk/splunkd.pid"
  $data_dir = "${splunk::basedir}/var/lib/splunk"
  $log_dir = "${splunk::basedir}/var/log/splunk"
  $log_file = "${splunk::basedir}/var/log/splunk/splunkd.log"

  ### Definition of some variables used in the module
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_puppi=any2bool($puppi)
  $bool_monitor=any2bool($monitor)
  $bool_firewall=any2bool($firewall)
  $bool_audit_only=any2bool($audit_only)
  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_debug=any2bool($debug)

  $manage_package = $splunk::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_service_enable = $splunk::bool_disableboot ? {
    true    => false,
    default => $splunk::bool_disable ? {
      true    => false,
      default => $splunk::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $splunk::bool_disable ? {
    true    => 'stopped',
    default =>  $splunk::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_file = $splunk::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  # If $splunk::disable == true we dont check splunk on the local system
  if $splunk::bool_absent == true or $splunk::bool_disable == true or $splunk::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $splunk::bool_absent == true or $splunk::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $splunk::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $splunk::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $real_monitor_sourcetype = $splunk::monitor_sourcetype ? {
    ''      => '',
    default => "-sourcetype ${splunk::monitor_sourcetype}",
  }

  ### Managed resources

  # If install_source is defined installation is done retriving directly the defined source
  if $splunk::install_source != '' {

    $install_command = $::operatingsystem ? {
      /(?i:Debian|Ubuntu|Mint)/                        => "wget \'${splunk::install_source}\' -O /tmp/splunk.deb ; dpkg -i /tmp/splunk.deb",
      /(?i:RedHat|Centos|Scientific|Suse|OracleLinux)/ => "rpm -U ${splunk::install_source}",
    }

    exec { 'splunk_manage_package':
      command     => '/root/puppet_manage_package',
      refreshonly => true,
      before      => Package['splunk'],
    }

    file { 'splunk_manage_package':
      ensure   => present,
      path     => '/root/puppet_manage_package',
      mode     => '0700',
      owner    => 'root',
      group    => 'root',
      content  => template('splunk/manage_package.erb'),
      before   => Package['splunk'] ,
      notify   => Exec['splunk_manage_package'],
    }

  }

  package { 'splunk':
    ensure => $splunk::manage_package,
    name   => $splunk::package,
  }

  service { 'splunk':
    ensure     => $splunk::manage_service_ensure,
    name       => $splunk::service,
    enable     => $splunk::manage_service_enable,
    hasstatus  => $splunk::service_status,
    pattern    => $splunk::process,
    require    => Exec['splunk_create_service'],
  }

  exec { 'splunk_create_service':
    command  => "${splunk::basedir}/bin/splunk enable boot-start --accept-license --answer-yes --no-prompt",
    creates  => '/etc/init.d/splunk',
    require  => Package['splunk'],
  }

  # Setting of forward_server for forwarders
  if $splunk::forward_server {
    exec { 'splunk_add_forward_server':
      command     => "${splunk::basedir}/bin/puppet_add_forward_server",
      refreshonly => true,
      require     => Exec['splunk_change_admin_password'],
    }

    file { 'splunk_add_forward_server':
      ensure   => present,
      path     => "${splunk::basedir}/bin/puppet_add_forward_server",
      mode     => '0700',
      owner    => $splunk::config_file_owner,
      group    => $splunk::config_file_group,
      content  => template('splunk/add_forward_server.erb'),
      require  => Package['splunk'],
      notify   => Exec['splunk_add_forward_server'],
    }
  }

  # Setting of files or directories to be monitored
  if $splunk::monitor_path {
    exec { 'splunk_add_monitor':
      command     => "${splunk::basedir}/bin/puppet_add_monitor",
      refreshonly => true,
      require     => Exec['splunk_change_admin_password'],
    }

    file { 'splunk_add_monitor':
      ensure   => present,
      path     => "${splunk::basedir}/bin/puppet_add_monitor",
      mode     => '0700',
      owner    => $splunk::config_file_owner,
      group    => $splunk::config_file_group,
      content  => template('splunk/add_monitor.erb'),
      require  => Package['splunk'],
      notify   => Exec['splunk_add_monitor'],
    }
  }

  # Change of admin password
  exec { 'splunk_change_admin_password':
    command     => "${splunk::basedir}/bin/puppet_change_admin_password",
    refreshonly => true,
    require     => Service['splunk'],
  }

  file { 'splunk_change_admin_password':
    ensure  => present,
    path    => "${splunk::basedir}/bin/puppet_change_admin_password",
    mode    => '0700',
    owner   => $splunk::config_file_owner,
    group   => $splunk::config_file_group,
    content => template('splunk/change_admin_password.erb'),
    require => Package['splunk'],
    notify  => Exec['splunk_change_admin_password'],
  }

  # Local configuration files for which a template can be provided
  if $splunk::template_inputs {
    file { 'splunk_inputs.conf':
      ensure  => $splunk::manage_file,
      path    => "${splunk::basedir}/etc/system/local/inputs.conf",
      mode    => $splunk::config_file_mode,
      owner   => $splunk::config_file_owner,
      group   => $splunk::config_file_group,
      require => Package['splunk'],
      notify  => Service['splunk'],
      content => template($splunk::template_inputs),
      replace => $splunk::manage_file_replace,
      audit   => $splunk::manage_audit,
    }
  }

  if $splunk::template_outputs {
    file { 'splunk_outputs.conf':
      ensure  => $splunk::manage_file,
      path    => "${splunk::basedir}/etc/system/local/outputs.conf",
      mode    => $splunk::config_file_mode,
      owner   => $splunk::config_file_owner,
      group   => $splunk::config_file_group,
      require => Package['splunk'],
      notify  => Service['splunk'],
      content => template($splunk::template_outputs),
      replace => $splunk::manage_file_replace,
      audit   => $splunk::manage_audit,
    }
  }

  if $splunk::template_server {
    file { 'splunk_server.conf':
      ensure  => $splunk::manage_file,
      path    => "${splunk::basedir}/etc/system/local/server.conf",
      mode    => $splunk::config_file_mode,
      owner   => $splunk::config_file_owner,
      group   => $splunk::config_file_group,
      require => Package['splunk'],
      notify  => Service['splunk'],
      content => template($splunk::template_server),
      replace => $splunk::manage_file_replace,
      audit   => $splunk::manage_audit,
    }
  }

  if $splunk::template_web {
    file { 'splunk_web.conf':
      ensure  => $splunk::manage_file,
      path    => "${splunk::basedir}/etc/system/local/web.conf",
      mode    => $splunk::config_file_mode,
      owner   => $splunk::config_file_owner,
      group   => $splunk::config_file_group,
      require => Package['splunk'],
      notify  => Service['splunk'],
      content => template($splunk::template_web),
      replace => $splunk::manage_file_replace,
      audit   => $splunk::manage_audit,
    }
  }

  # The whole local splunk configuration directory can be recursively overriden
  if $splunk::source_dir {
    file { 'splunk.dir':
      ensure  => directory,
      path    => $splunk::config_dir,
      require => Package['splunk'],
      source  => $source_dir,
      recurse => true,
      purge   => $splunk::bool_source_dir_purge,
      replace => $splunk::manage_file_replace,
      audit   => $splunk::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $splunk::my_class {
    include $splunk::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $splunk::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'splunk':
      ensure    => $splunk::manage_file,
      variables => $classvars,
      helper    => $splunk::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $splunk::bool_monitor == true {
    monitor::port { "splunk_${splunk::protocol}_${splunk::port}":
      protocol => $splunk::protocol,
      port     => $splunk::port,
      target   => $splunk::monitor_target,
      tool     => $splunk::monitor_tool,
      enable   => $splunk::manage_monitor,
    }
    monitor::process { 'splunk_process':
      process  => $splunk::process,
      service  => $splunk::service,
      pidfile  => $splunk::pid_file,
      tool     => $splunk::monitor_tool,
      enable   => $splunk::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $splunk::bool_firewall == true {
    firewall { "splunk_${splunk::protocol}_${splunk::port}":
      source      => $splunk::firewall_src,
      destination => $splunk::firewall_dst,
      protocol    => $splunk::protocol,
      port        => $splunk::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $splunk::firewall_tool,
      enable      => $splunk::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $splunk::bool_debug == true {
    file { 'debug_splunk':
      ensure  => $splunk::manage_file,
      path    => "${settings::vardir}/debug-splunk",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}
