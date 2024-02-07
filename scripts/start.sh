tailscaled &
echo "Waiting for tailscaled to start"
sleep 10
echo "Logging in to tailscale"
tailscale login --authkey=${TS_AUTHKEY}
echo "Waiting for tailscale to log in"
sleep 10
echo "Generating HTTPS certificates"
tailscale cert --cert-file=/config/tailscale.crt --key-file=/config/tailscale.key ${TS_DOMAIN}
echo "Done!"
wait
