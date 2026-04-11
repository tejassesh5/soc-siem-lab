# Zeek local site policy — SOC lab configuration

@load base/frameworks/notice
@load base/frameworks/signatures
@load base/protocols/conn
@load base/protocols/dns
@load base/protocols/http
@load base/protocols/ssh
@load base/protocols/ssl
@load base/protocols/ftp
@load base/protocols/smtp

# Detect horizontal port scans
@load policy/misc/scan

# Log all files transferred
@load base/frameworks/files
@load base/files/hash

# Detect specific signatures
@load base/frameworks/signatures

# Known bad intel framework
@load frameworks/intel/seen
@load frameworks/intel/do_notice

# Capture full SSL certificate chains
@load protocols/ssl/validate-certs

# Log HTTP and DNS for traffic analysis
@load tuning/logs-to-elasticsearch

redef Log::default_rotation_interval = 1hr;

redef Site::local_nets = {
    10.0.0.0/8,
    172.16.0.0/12,
    192.168.0.0/16,
};

# Hash all transferred files (MD5 + SHA256) for IOC matching
event file_new(f: fa_file)
{
    Files::add_analyzer(f, Files::ANALYZER_MD5);
    Files::add_analyzer(f, Files::ANALYZER_SHA256);
}

# Notice on SSH brute force (>5 failures in 60s from same IP)
redef SSH::password_guesses_limit = 5;

# Log DNS queries for threat hunting
redef DNS::max_pending_msgs = 100;
