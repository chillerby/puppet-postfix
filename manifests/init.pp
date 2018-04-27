# postfix_config
#
# A description of what this class does
#This class controls the configuration of postfix and it's related files.
# @summary A short summary of the purpose of this class
#
# @example
#   include postfix_config
class postfix_config {
    $package_name = 'postfix'
    $config_directory = '/etc/postfix'
    $command_directory = '/usr/sbin'
    $daemon_directory = '/usr/libexec/postfix'
    $data_directory = '/var/lib/postfix'
    $queue_directory = '/var/spool/postfix'
    $postfix_version = '2.6.6'
    $manpage_directory = '/usr/share/man'
    $readme_directory = "/usr/share/doc/postfix-${postfix_version}/README_FILES"
    $sample_directory = "/usr/share/doc/postfix-${postfix_version}/samples"
    $service_restart = '/sbin/service postfix reload'
    $dovecot_directory = '/usr/libexec/dovecot'
#   $myhostname = 'mx2.turnitin.com'
#   $myorigin = '$myhostname'
    $inet_interfaces = 'all'
    $inet_protocols = 'ipv4'
    $mydestination = '$myhostname, localhost.$mydomain, localhost'
    $unknown_local_recipient_reject_code = '550'
    $smtpd_recipient_restrictions_list = 'hash:/etc/postfix/bad_recipients'

service { 'postfix':
    ensure  => running,
    require => Package[$package_name],
    enable  => true,
}

file { "${config_directory}/master.cf":
    content => template('postfix/master.cf.erb'),
    notify  => Service['postfix'],
    require => Package[$package_name],
}
file { "${config_directory}/main.cf":
    content => template('postfix/main.cf.erb'),
    notify  => Service['postfix'],
    require => Package[$package_name],
}
}
