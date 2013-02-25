Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
File { owner => 0, group => 0, mode => 0644 }
stage { 'first': }
stage { 'last': }
Stage['first'] -> Stage['main'] -> Stage['last']

import 'basic.pp'
import 'nodes.pp'

class{'basic':
  stage => first
}


class{"runit":}
-> class{"varnish":}
-> class{"heartbeat":}
-> class{"openresty":}
-> class{"redis":}
-> class{"memcached":}



# a helper script to run nginx tests
# runs puppet + runs the unit tests
file{"/usr/local/bin/nginx_tests":
  content => "
    cd /vagrant/nginx_tests && \
    runpuppet && \
    ruby nginx_test.rb",
  mode    => 0755
}