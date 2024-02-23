tailscaled &
echo "Waiting for tailscaled to start"
sleep 10
echo "Logging in to tailscale"
# Check `tailscale status` to see if we're already logged in. If we are, don't log in again.
# `tailscale status` returns status code 0 if logged in
if tailscale status; then
  echo "Already logged in to tailscale"
else
  echo "Not logged in to tailscale"
  if [ -z "${TS_AUTHKEY}" ]; then
    echo "No authkey provided"
    tailscale login --qr
  else
    tailscale login --authkey=${TS_AUTHKEY}
  fi
  echo "Waiting for tailscale to log in"
  sleep 10
fi

echo "Generating HTTPS certificates"
tailscale cert --cert-file=/config/tailscale.crt --key-file=/config/tailscale.key ${TS_DOMAIN}
echo "Done!"
wait
