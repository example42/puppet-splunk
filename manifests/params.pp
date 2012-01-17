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

  $install = $::splunk_install ? {
    ''      => 'forwarder',               # Default value
    default => $::splunk_install,
  }

  $install_source = $::splunk_install_source ? {
    ''      => '',                        # Default value
    default => $::splunk_install_source,
  }

  $admin_password = $::splunk_admin_password ? {
    ''      => 'changeme',                # Default value
    default => $::splunk_admin_password,
  }

  $forward_server = $::splunk_forward_server ? {
    ''      => '',                        # Default value
    default => $::splunk_forward_server,
  }

  $monitor_path = $::splunk_monitor_path ? {
    ''      => '',                        # Default value
    default => $::splunk_monitor_path,
  }

  $template_inputs = $::splunk_template_inputs ? {
    ''      => '',                        # Default value
    default => $::splunk_template_inputs,
  }

  $template_outputs = $::splunk_template_outputs ? {
    ''      => '',                        # Default value
    default => $::splunk_template_outputs,
  }

  $template_server = $::splunk_template_server ? {
    ''      => '',                        # Default value
    default => $::splunk_template_server,
  }

  $template_web = $::splunk_template_web ? {
    ''      => '',                        # Default value
    default => $::splunk_template_web,
  }

  $port = $::splunk_port ? {
    ''      => '8089',                    # Default value
    default => $::splunk_port,
  }

  $protocol = $::splunk_protocol ? {
    ''      => 'tcp',                   # Default value
    default => $::splunk_protocol,
  }


  ### General variables that affect module's behaviour
  # They can be set at top scope level or in a ENC

  $my_class = $::splunk_my_class ? {
    ''      => '',                      # Default value
    default => $::splunk_my_class,
  }

  $source_dir = $::splunk_source_dir ? {
    ''      => '',                      # Default value
    default => $::splunk_source_dir,
  }

  $source_dir_purge = $::splunk_source_dir_purge ? {
    ''      => false,                   # Default value
    default => $::splunk_source_dir_purge,
  }

  $options = $::splunk_options ? {
    ''      => '',                      # Default value
    default => $::splunk_options,
  }

  $absent = $::splunk_absent ? {
    ''      => false,                   # Default value
    default => $::splunk_absent,
  }

  $disable = $::splunk_disable ? {
    ''      => false,                   # Default value
    default => $::splunk_disable,
  }

  $disableboot = $::splunk_disableboot ? {
    ''      => false,                   # Default value
    default => $::splunk_disableboot,
  }


  ### General module variables that can have a site or per module default
  # They can be set at top scope level or in a ENC

  $monitor = $::splunk_monitor ? {
    ''      => $::monitor ? {
      ''      => false,                # Default value
      default => $::monitor,
    },
    default => $::splunk_monitor,
  }

  $monitor_tool = $::splunk_monitor_tool ? {
    ''      => $::monitor_tool ? {
      ''      => '',                   # Default value
      default => $::monitor_tool,
    },
    default => $::splunk_monitor_tool,
  }

  $monitor_target = $::splunk_monitor_target ? {
    ''      => $::monitor_target ? {
      ''      => $::ipaddress,         # Default value
      default => $::monitor_target,
    },
    default => $::splunk_monitor_target,
  }

  $firewall = $::splunk_firewall ? {
    ''      => $::firewall ? {
      ''      => false,                # Default value
      default => $::firewall,
    },
    default => $::splunk_firewall,
  }

  $firewall_tool = $::splunk_firewall_tool ? {
    ''      => $::firewall_tool ? {
      ''      => '',                   # Default value
      default => $::firewall_tool,
    },
    default => $::splunk_firewall_tool,
  }

  $firewall_src = $::splunk_firewall_src ? {
    ''      => $::firewall_src ? {
      ''      => '0.0.0.0/0',          # Default value
      default => $::firewall_src,
    },
    default => $::splunk_firewall_src,
  }

  $firewall_dst = $::splunk_firewall_dst ? {
    ''      => $::firewall_dst ? {
      ''      => $::ip_address,        # Default value
      default => $::firewall_dst,
    },
    default => $::splunk_firewall_dst,
  }

  $puppi = $::splunk_puppi ? {
    ''      => $::puppi ? {
      ''      => false,                # Default value
      default => $::puppi,
    },
    default => $::splunk_puppi,
  }

  $puppi_helper = $::splunk_puppi_helper ? {
    ''      => $::puppi_helper ? {
      ''      => 'standard',           # Default value
      default => $::puppi_helper,
    },
    default => $::splunk_puppi_helper,
  }

  $debug = $::splunk_debug ? {
    ''      => $::debug ? {
      ''      => false,                # Default value
      default => $::debug,
    },
    default => $::splunk_debug,
  }

  $audit_only = $::splunk_audit_only ? {
    ''      => $::audit_only ? {
      ''      => false,                # Default value
      default => $::audit_only,
    },
    default => $::splunk_audit_only,
  }

}
