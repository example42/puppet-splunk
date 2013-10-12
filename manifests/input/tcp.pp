# Define splunk::input::tcp
#
define splunk::input::tcp ( $port,
  $remote_server        = '',
  $host                 = undef,
  $index                = undef,
  $source               = undef,
  $sourcetype           = undef,
  $queue                = undef,
  $connection_host      = undef,
  $queueSize            = undef,
  $persistentQueueSize  = undef,
  $requireHeader        = undef,
  $listenOnIPv6         = undef,
  $acceptFrom           = undef,
  $rawTcpDoneTimeout    = undef
) {
  include splunk

  if ! defined(Concat['inputs.conf']) {
    concat { 'inputs.conf':
      path   => "${splunk::basedir}/etc/system/local/inputs.conf",
      notify => Service['splunk']
    }
  }
  concat::fragment { "tcp-${title}":
    target  => 'inputs.conf',
    content => template( 'splunk/input/tcp.erb' )
  }
}
