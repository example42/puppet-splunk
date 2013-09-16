define splunk::monitor ( $path, 
        $host_regex=undef, 
        $host_segment=undef, 
        $whitelist=undef, 
        $blacklist=undef, 
        $crcSalt=undef, 
        $initCrcLength=undef, 
        $ignoreOlderThan=undef, 
        $followTail=undef, 
        $alwaysOpenFile=undef, 
        $time_before_close=undef, 
        $recursive=undef, 
        $followSymlink=undef
) {

    include splunk
	concat::fragment { "monitor-$path":
		target => 'input.conf',
		content => template( 'splunk/input.fragment.erb' )
	}
}
