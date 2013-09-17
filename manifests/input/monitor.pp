define splunk::monitor ( $path, 
  $host               = undef,
  $index              = undef,
  $source             = undef,
  $sourcetype         = undef,
  $queue              = undef,
  $host_regex         = undef, 
  $host_segment       = undef, 
  $whitelist          = undef, 
  $blacklist          = undef, 
  $crcSalt            = undef, 
  $initCrcLength      = undef, 
  $ignoreOlderThan    = undef, 
  $followTail         = undef, 
  $alwaysOpenFile     = undef, 
  $time_before_close  = undef, 
  $recursive          = undef, 
  $followSymlink      = undef
) {
  include splunk

  realize Concat['inputs.conf']
  concat::fragment { "monitor-$title":
    target => 'inputs.conf',
    content => template( 'splunk/input.fragment.erb' )
  }
}

