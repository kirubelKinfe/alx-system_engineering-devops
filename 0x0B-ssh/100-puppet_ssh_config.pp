# Configures SSH client to use private key ~/.ssh/school and disable password authentication

file { '/home/ubuntu/.ssh':
  ensure => directory,
  owner  => 'ubuntu',
  group  => 'ubuntu',
  mode   => '0700',
}

file { '/home/ubuntu/.ssh/config':
  ensure  => file,
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0600',
  require => File['/home/ubuntu/.ssh'],
}

file_line { 'Turn off passwd auth':
  path    => '/home/ubuntu/.ssh/config',
  line    => '    PasswordAuthentication no',
  match   => '^[#\s]*PasswordAuthentication\s.*$',
  require => File['/home/ubuntu/.ssh/config'],
}

file_line { 'Declare identity file':
  path    => '/home/ubuntu/.ssh/config',
  line    => '    IdentityFile ~/.ssh/school',
  match   => '^[#\s]*IdentityFile\s.*$',
  require => File['/home/ubuntu/.ssh/config'],
}

file_line { 'Add host configuration':
  path    => '/home/ubuntu/.ssh/config',
  line    => "Host alx-server\n    HostName your_server_ip\n    User your_username",
  match   => '^Host alx-server$',
  require => File['/home/ubuntu/.ssh/config'],
}
