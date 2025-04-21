#!/bin/bash
set -e

if [[ $EID == 0 ]]; then
  echo "You must run this as root"
  exit 1
fi

tee /usr/lib/systemd/system/qubes-dynamic-dns-resolver.service >/dev/null <<'EOF'
[Unit]
Description=Qubes-Dynamic-DNS-Resolver

[Service]
Type=simple
ExecStart=/bin/sh -c 'case "$(qubesdb-read /vm-config/qubes-dynamic-dns-resolver 2>/dev/null)" in \
  dnscrypt-proxy-direct)  exec /usr/bin/dnscrypt-proxy -config /etc/dnscrypt-proxy/dnscrypt-proxy-direct.toml;; \
  stubby)                 exec /usr/bin/stubby;; \
  *)                      exec /usr/bin/dnscrypt-proxy -config /etc/dnscrypt-proxy/dnscrypt-proxy.toml;; \
esac'

Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload --force
systemctl enable qubes-dynamic-dns-resolver
