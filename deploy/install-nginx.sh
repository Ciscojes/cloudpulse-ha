#!/bin/bash
set -euo pipefail

PROJECT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
WEB_ROOT=/usr/share/nginx/html

for asset in index.html styles.css deployment.js; do
  [[ -f "$PROJECT_ROOT/$asset" ]] || { echo "Archivo no encontrado: $asset" >&2; exit 1; }
done

dnf install -y nginx

TOKEN=$(curl --fail --silent --show-error --connect-timeout 3 --max-time 10 --retry 3 -X PUT \
  http://169.254.169.254/latest/api/token -H 'X-aws-ec2-metadata-token-ttl-seconds: 300')
INSTANCE_ID=$(curl --fail --silent --show-error --connect-timeout 3 --max-time 10 --retry 3 \
  -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl --fail --silent --show-error --connect-timeout 3 --max-time 10 --retry 3 \
  -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)

[[ "$INSTANCE_ID" =~ ^i-[0-9a-f]{8,17}$ ]] || { echo 'Instance ID inválido' >&2; exit 1; }
[[ "$AZ" =~ ^eu-west-1[a-z]$ ]] || { echo 'Zona de disponibilidad inválida' >&2; exit 1; }

install -d -m 0755 "$WEB_ROOT"
for asset in index.html styles.css deployment.js; do
  install -m 0644 "$PROJECT_ROOT/$asset" "$WEB_ROOT/$asset"
done
printf '{"instanceId":"%s","availabilityZone":"%s"}\n' "$INSTANCE_ID" "$AZ" > "$WEB_ROOT/identity.json"
printf 'ok\n' > "$WEB_ROOT/healthz"
chmod 0644 "$WEB_ROOT/identity.json" "$WEB_ROOT/healthz"

cat > /etc/nginx/conf.d/cloudpulse-cache.conf <<'NGINX'
map $uri $cloudpulse_cache_control {
    default "no-cache";
    /identity.json "no-store, max-age=0";
    /healthz "no-store, max-age=0";
}
add_header Cache-Control $cloudpulse_cache_control always;
NGINX

nginx -t
systemctl enable nginx
systemctl restart nginx
curl --fail --silent --show-error http://127.0.0.1/healthz
echo "CloudPulse desplegado en $INSTANCE_ID ($AZ)"
