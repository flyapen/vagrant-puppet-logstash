node "logstash" {

  include apt
  apt::source { "aeolus":
    location => "http://aeolus.ugent.be/debian/",
    release => "squeeze",
    repos => "main"
  }

  service {"iptables":
    enable => false,
    ensure => stopped;
  }



  package { 'openjdk-6-jdk':
    ensure => 'installed';
  }

  package { 'tanukiwrapper':
    ensure => '3.5.7-1.jpp6',
   }



  class {'elasticsearch':
    version => '0.18.7-1.el6',
  }
  package {'elasticsearch-plugin-head':
    ensure => 'installed',
  }

  include rabbitmq
  include grok 
  include logstash::common 
  class {'logstash::shipper':
    verbose => 'yes',
  }

  class {'logstash::server':
    verbose => 'yes',
  }
  include logstash::web

  service {"httpd":  ensure => running; }
  include kibana

}
