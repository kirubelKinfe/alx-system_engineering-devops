# Installs and configures Nginx with a "Hello World!" page and a 301 redirect for /redirect_me

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

# Configure Nginx with a default site including the redirect
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => @("EOF")
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html;

    server_name _;

    location / {
        try_files \$uri \$uri/ /index.html;
    }

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
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