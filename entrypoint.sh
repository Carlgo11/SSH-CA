#!/bin/sh

# Replace $fingerprint with actual key fingerprint
edit_configs() {
    sed -e "s/\$fingerprint/$1/g" daemon_config.json > daemon_config.json.edited
    sed -e "s/\$fingerprint/$1y/g" signer_config.json > signer_config.json.edited
}

# Generate CA key
generate_key() {
    echo "No key found at ${KEY_PATH}. Generating new key..."
    ssh-keygen -b "${KEY_BITS}" -C 'certificate_authority' -N '' -f "${KEY_PATH}" -q
    pubkey=`cat "${KEY_PATH}".pub`
    echo "public key: ${pubkey}"
    echo "MD5 fingerprint: $key"
}

# Start ssh-agent
eval `ssh-agent -s` > /dev/null

[[ -f "${KEY_PATH}" ]] || generate_key

# Add SSH key
ssh-add -q "${KEY_PATH}"

# List SSH keys
key=`ssh-add -E md5 -l | head -n 1 | awk '{ printf($2) }' | cut -c 5-`

edit_configs $key

# Start ssh-cert-authority server
ssh-cert-authority runserver --listen-address "${ADDRESS}":"${PORT}" "$@"
