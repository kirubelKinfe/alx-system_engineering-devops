# Installs and configures Nginx with a custom HTTP header X-Served-By containing the hostname

# Ensure the Nginx package is installed
package { 'nginx':
  ensure => installed,
}

# Create the index.html file with "Hello World!"
file { '/var/www/html/index.html':
  ensure  => file,
  content => "Hello World!\n",
  require => Package['nginx'],
}

# Get the hostname dynamically
$hostname = $facts['networking']['hostname']

# Configure Nginx to listen on port 80 and add the X-Served-By header
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => @("EOF")
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html;

    server_name _;

    add_header X-Served-By ${hostname};

    location / {
        try_files \$uri \$uri/ /index.html;
    }
}
EOF
  ,
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure     => running,
  enable     => true,
  require    => [Package['nginx'], File['/etc/nginx/sites-available/default']],
  hasrestart => true,
  restart    => '/usr/sbin/service nginx reload',
}