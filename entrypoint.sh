#!/bin/sh

# Starting ssh-agent
eval `ssh-agent -s` > /dev/null

if [ ! -f /ssh.key ]; then
echo "No key found at /ssh.key. Generating new key..."
ssh-keygen -b 4096 -C 'certificate_authority' -N '' -f /ssh.key -q
pubkey=`cat /ssh.key.pub`
echo "public key: ${pubkey}"

fi

# Adding SSH key
ssh-add -q ssh.key

# Listing SSH keys
key=`ssh-add -E md5 -l | head -n 1 | awk '{ printf($2) }' | cut -c 5-`
echo "MD5 fingerprint: $key"
sed -e "s/\$fingerprint/$key/g" config.json > sign_certd_config.json

echo ""

# Starting ssh-cert-authority server
ssh-cert-authority runserver --listen-address 0.0.0.0:"${PORT}" --config-file /sign_certd_config.json
