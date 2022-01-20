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
1. Open `daemon_config.json` and replace `hash` with your fingerprint from the previous command.
1. Replace `user@hostname` with your username and hostname.
## Usage

To start the server do:
```SH
docker-compose up -d
```
