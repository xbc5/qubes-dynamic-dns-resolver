# Qubes Dynamic DNS Resolver

A simple unit file that works for my needs. It selects a DNS resolver based on a VM configuration value.

This script would be awkward for most to use, but it works for my simple use case.

Run the installer in your template, then in dom0 run:

```sh
qvm-features YOUR-DOMAIN vm-config.qubes-dynamic-dns-resolver RESOLVER-NAME
```

Where `RESOLVER-NAME` is one of `dnscrypt-proxy-direct`, `stubby`, or not set at all--which defaults to dnscrypt-proxy's default configuration.
