# postfix_config
#
# A description of what this class does
#This class controls the configuration of postfix and it's related files.
# @summary A short summary of the purpose of this class
#
# @example
#   include postfix_config
class postfix_config (
    $package_name = 'postfix',
    $queue_directory = '/var/spool/postfix',
    $config_directory = '/etc/postfix',
    $command_directory = '/usr/sbin',
    $daemon_directory = '/usr/libexec/postfix',
    $data_directory = '/var/lib/postfix',
    $myhostname = 'mx2.turnitin.com',
    $mydomain = undef,
    $myorigin = '$myhostname',
    $inet_interfaces = 'all',
    $inet_protocols = 'ipv4',
    $proxy_interfaces = undef,
    $mydestination = '$myhostname, localhost.$mydomain, localhost',
    $local_recipient_maps = undef,
    $luser_relay = undef,
    $unknown_local_recipient_reject_code = '550',
    $mynetworks_style = undef,
    $mynetworks = '127.0.0.0/8, [::1]/128, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, 67.203.85.0/24, 67.203.111.0/24, 174.47.2.0/24, 38.111.147.0/24, 199.47.86.0/24, 199.47.85.0/28',
    $relay_domains = undef,
    $relayhost = undef,
    $relay_recipient_maps = undef,
    $in_flow_delay = '1s',
    $masquerade_classes = undef,
    $masquerade_domains = 'turnitin.com devstk ithenticate.com s2prod ca2prd',
    $alias_maps = 'hash:/etc/aliases',
    $alias_database = 'hash:/etc/aliases',
    $recipient_delimiter = undef,
    $home_mailbox = undef,
    $mail_spool_directory = undef,
    $mailbox_command = undef,
    $smtpd_banner = '$myhostname ESMTP $mail_name',
    $mailbox_size_limit = undef,
    $message_size_limit = undef,
    $mail_name = undef,
    $sendmail_path = '/usr/sbin/sendmail.postfix',
    $newaliases_path = '/usr/bin/newaliases.postfix',
    $mailq_path = '/usr/bin/mailq.postfix',
    $setgid_group = 'postdrop',
    $postfix_version = '2.6.6',
    $manpage_directory = '/usr/share/man',
    $readme_directory = "/usr/share/doc/postfix-${postfix_version}/README_FILES",
    $sample_directory = "/usr/share/doc/postfix-${postfix_version}/samples",
    $canonical_maps = '/etc/postfix',
    $service_restart = '/sbin/service postfix reload',
    $dovecot_directory = '/usr/libexec/dovecot',
    $smtpd_recipient_restrictions_list = 'hash:/etc/postfix/bad_recipients',
)
{
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
