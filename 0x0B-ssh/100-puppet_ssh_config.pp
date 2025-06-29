# Puppet manifest to configure SSH client
# Configure SSH client to use private key and disable password authentication

file_line { 'Declare identity file':
  path => '/etc/ssh/ssh_config',
  line => '    IdentityFile ~/.ssh/school',
  match => '^#?[[:space:]]*IdentityFile',
}

file_line { 'Turn off passwd auth':
  path => '/etc/ssh/ssh_config',
  line => '    PasswordAuthentication no',
  match => '^#?[[:space:]]*PasswordAuthentication',
} 