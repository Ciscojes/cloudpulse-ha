#!/bin/bash
# Amazon Linux 2023. Puede ejecutarse como User Data o con sudo bash.
# No crea instancias, reglas de red, roles, balanceadores ni otros recursos AWS.
set -euo pipefail
dnf install -y nginx
WEB_ROOT=/usr/share/nginx/html
install -d -m 0755 "$WEB_ROOT"
base64 -d <<'CLOUDPULSE_ASSETS' | tar -xz -C "$WEB_ROOT"
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
CLOUDPULSE_ASSETS
# Retirar únicamente el archivo de la antigua demo de CloudPulse.
rm -f -- "$WEB_ROOT/script.js"
TOKEN=$(curl --fail --silent --show-error --connect-timeout 3 --max-time 10 --retry 3 -X PUT \
  http://169.254.169.254/latest/api/token -H 'X-aws-ec2-metadata-token-ttl-seconds: 300')
INSTANCE_ID=$(curl --fail --silent --show-error --connect-timeout 3 --max-time 10 --retry 3 \
  -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl --fail --silent --show-error --connect-timeout 3 --max-time 10 --retry 3 \
  -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)
[[ "$INSTANCE_ID" =~ ^i-[0-9a-f]{8,17}$ ]] || { echo 'Instance ID inválido'; exit 1; }
[[ "$AZ" =~ ^eu-west-1[a-z]$ ]] || { echo 'AZ fuera de la región prevista'; exit 1; }
printf '{"instanceId":"%s","availabilityZone":"%s"}\n' "$INSTANCE_ID" "$AZ" > "$WEB_ROOT/identity.json"
printf 'ok\n' > "$WEB_ROOT/healthz"
chmod 0644 "$WEB_ROOT/index.html" "$WEB_ROOT/styles.css" "$WEB_ROOT/deployment.js" "$WEB_ROOT/identity.json" "$WEB_ROOT/healthz"
cat > /etc/nginx/conf.d/cloudpulse-cache.conf <<'NGINX'
# En cada upstream debe devolverse su propia identidad; no almacenar en caché.
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
