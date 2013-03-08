## Puppet module: splunk

This is a Puppet splunk module from the second generation of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42 - http://www.example42.com

Released under the terms of Apache 2 License.

Check Modulefile for dependencies.

##= GENERAL USAGE
This module installs splunk server or splunk universal forwarder.
It uses packages that can be retrieved from http://www.splunk.com.
It has been tested on version 4.3 but should work also on earlier releases.

Note that you have to specify a package_source if you don't have the relevant
packages in your repo(s).

To install Splunk server (searcher, indexer, web interface) via yum/apt:

        class { "splunk":
          install => "server",
        }

To install Universal Forwarder via yum/apt:

        class { "splunk":
          install        => "forwarder", # This is the default, can be omitted 
          forward_server => "splunk.example42.com:9997", # Use host:port format
        }

To install the Splunk server form a custom url

        class { "splunk":
          install        => "server",
          install_source => "http://files.example42.com/splunk-4.3-115073-linux-2.6-x86_64.rpm",
          admin_password => "mypassword",
        }

To install the Universal Forwarder from a custom url, setting an admin password and custom
local files to forward:

        class { "splunk":
          # install        => "forwarder", # This is the default, can be omitted 
          install_source => "http://files.example42.com/splunkforwarder-4.3-115073-linux-2.6-amd64.deb",
          forward_server => "splunk.example42.com:9997", # Use host:port format
          monitor_path   => [ "/var/log/tomcat6/catalina.out" , "/var/log/apache2/" ],
          admin_password => "!what4wONDErFu!P4ssw0rd",
        }

The variables used in the module can be passed in 2 ways:

* With the old style "Set variables and include class" pattern:

        $splunk_forward_server = "splunk.example42.com:9997",
        include splunk

* As a parametrized class:

        class { "splunk":
          forward_server => "splunk.example42.com:9997",
        }

You can even, under some degrees, mix these two patterns.

You can for example set general top scope variables that affect all your parametrized classes:

        $puppi = true
        $monitor = true
        $monitor_tool = [ "nagios" , "munin" , "puppi" ]
        class { "splunk":
          forward_server => "splunk.example42.com:9997",
        }
        
The above example has the same effect of:

        class { "splunk":
          forward_server => "splunk.example42.com:9997",
          puppi          => true,
          monitor        => true,
          monitor_tool   => [ "nagios" , "munin" , "puppi" ],
        }

Note that if you use the "Set variables and include class" pattern you can define variables only
at the top level scope or in a ENC (External Node Classifer) like Puppet Dashboard, Puppet Enterprise Console or The Foreman.

Below you have an overview of the most important module's parameters (you can mix and aggregate them).

The examples use parametrized classes, but for all the parameters you can set a $splunk_ top scope variable.

For example, the variable "$splunk_absent" is equivant to the "absent =>" parameter.

##= USAGE - Basic management
* Install splunk with default settings

        class { "splunk": }

* Disable splunk service.

        class { "splunk":
          disable => true,
        }

* Disable splunk service at boot time, but don't stop if is running.

        class { "splunk":
          disableboot => true,
        }

* Remove splunk package

        class { "splunk":
          absent => true,
        }

* Enable auditing without without making changes on existing splunk configuration files

        class { "splunk":
          audit_only => true,
        }


##= USAGE - Overrides and Customizations
* You can set custom sources for some commonly used splunk configuration files
Note that if you do this, the omonimous existing files ( in $splunkdir/etc/system/local ) are 
removed. So, for example, the name of the forward server set with $forward_server is ignored
if you use a custom template_server

        class { "splunk":
          template_inputs  => "example42/splunk/inputs.conf.erb",
          template_outputs => "example42/splunk/outputs.conf.erb",
          template_server  => "example42/splunk/server.conf.erb",
          template_web     => "example42/splunk/web.conf.erb",
        }


* Use custom source directory for the whole configuration dir
Also for this case existing configuration might be overwritten

        class { "splunk":
          source_dir       => "puppet:///modules/example42/splunk/conf/",
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Define custom options that can be used in the custom templates without the
  need to add parameters to the splunk class

        class { "splunk":
          template_inputs => "example42/splunk/inputs.conf.erb",
          options  => {
            'fschange' => [ "/etc" , "/usr/local/etc" ]
            'monitor'  => [ "/var/log/apache/error.log" , "/var/log/tomcat/catalina.out" ],
          },
        }

* Automaticallly include a custom subclass

        class { "splunk:"
          my_class => 'splunk::example42',
        }


##= USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)
  Note that this option requires the usage of Example42 puppi module

        class { "splunk": 
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with
  a puppi::helper define ) to customize the output of puppi commands 

        class { "splunk":
          puppi        => true,
          puppi_helper => "myhelper", 
        }

* Activate automatic monitoring (recommended, but disabled by default)
  This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { "splunk":
          monitor      => true,
          monitor_tool => [ "nagios" , "monit" , "munin" ],
        }

* Activate automatic firewalling 
  This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { "splunk":       
          firewall      => true,
          firewall_tool => "iptables",
          firewall_src  => "10.42.0.0/24",
          firewall_dst  => "$ipaddress_eth0",
        }



[![Build Status](https://travis-ci.org/example42/puppet-splunk.png?branch=master)](https://travis-ci.org/example42/puppet-splunk)
