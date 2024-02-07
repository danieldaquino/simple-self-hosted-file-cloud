Simple self-hosted file cloud
=============================

This is a very simple self-hosted file server for personal home use. It is designed to be run on a Raspberry Pi or similar home server. It is not designed to be a full-featured file server, but rather a simple self-hosted file cloud you can access from anywhere in the world.

⚠️ **Warning:** This software is still highly experimental and it has not been extensively tested yet. Please proceed with caution and use at your own risk.

## Features

- Single directory file sharing
- Tailscale integration out-of-the-box for secure remote access
- Tailscale Magic DNS support and default port usage (i.e. No need to remember weird port numbers when connecting)
- Dockerized for easy deployment
- No username and password setup (Tailscale is used for authentication. Anyone with access to the Tailscale network can access the file server)
- Ports are not exposed to your local network or the internet for extra safety (only accessible via Tailscale)
- Configurable directory to choose where to save files (e.g. on an external hard drive)
- TLS encryption and automated certificate setup on top of Tailscale (Tailscale uses WireGuard, which is already encrypted, but this adds an extra layer of encryption for the Samba server)

## How it works

It uses a Samba server inside Docker containers which are connected directly to a Tailscale VPN. The Samba server is configured to share a single directory, and the Tailscale VPN is used to connect to the server from anywhere in the world.

## Installation

1. Install Docker
2. Get an auth key from your Tailscale account [here](https://login.tailscale.com/admin/settings/keys)
3. Enable Magic DNS in Tailscale settings and get your Tailscale tailnet name [here](https://login.tailscale.com/admin/dns)
3. Create an `.env` file in this directory with the following content:

```
TS_AUTHKEY="<YOUR_TAILSCALE_AUTHKEY>"
TS_DOMAIN="files.<YOUR_TAILNET_NAME>.ts.net"
DATA_VOLUME_PATH="<PATH_TO_THE_DIRECTORY_YOU_WANT_TO_SHARE>"
```
**Tip:** If you do not specify `DATA_VOLUME_PATH`, the default path will be `./data` in this directory.

4. Run `docker-compose up -d` to start the server
5. Wait for about 1 minute for the server to start configure itself
6. Access the server via `smb://files.<YOUR_TAILNET_NAME>.ts.net` in your file explorer!

## Usage

### Mac

1. Open Finder
2. Press `Cmd + K`
3. Enter `smb://files.<YOUR_TAILNET_NAME>.ts.net`
4. Press `Connect`
5. You will be prompted to enter user information. Just choose "Guest" and press `Connect`
6. You should now see the shared directory mounted on your computer

### Windows

Here is an article on how to connect to a Samba server on Windows: [https://www.techrepublic.com/article/how-to-connect-to-linux-samba-shares-from-windows-10/](https://www.techrepublic.com/article/how-to-connect-to-linux-samba-shares-from-windows-10/)

### Linux

Varies depending on the distribution, but you can use the `smbclient` command to connect to the server.

## Contributing

Feel free to open an issue, a pull request, or send a patch via email to [daniel@daquino.me](mailto:daniel@daquino.me). I would love to hear your feedback and suggestions!

## Acknowledgements

- [https://mrpowergamerbr.com/us/blog/2023-03-20-untangling-your-network-tailscale-in-docker-compose/] for the inspiration in setting up Tailscale for Docker containers
- Tailscale, Samba, and Docker for the amazing software they provide
