# SSH CA as a Container

This project incorperates [cloudtools/ssh-cert-authority](https://github.com/cloudtools/ssh-cert-authority/) into a Docker container for easy use.

## Requirements

* Docker
* Docker-Compose

## Installation

1. Download this project.
1. Choose a current key you use and get the MD5 fingerprint of that key.
    ```sh
    ssh-keygen -l -E md5 -f [YOUR KEY PATH] | head -n 1 | awk '{ printf($2) }' | cut -c 5-
    ```
1. Open `daemon_config.json` and replace:
    * `hash` with your fingerprint from the previous command.
    * `user@hostname` with your username and hostname.

## Usage

To start the server do:
```SH
docker-compose up -d
```

The CA server should now be available on `http://127.0.0.1:8080`. To change the port edit the `docker-compose.yml`

To interact with the server, download the latest ssh-cert-authority binary from [cloudtools/ssh-cert-authority](https://github.com/cloudtools/ssh-cert-authority/).
Packages may also be available for some distributions.

## Environment variables

|name|default value|description|
|----|-------------|-----------|
|ADDRESS|0.0.0.0|Listening IP|
|PORT|8080|Listening port|
|KEY_BITS|4096|Bit size for generating new SSH CA key|
|KEY_PATH|/keys/key.pem|SSH CA Key path|
