#!/bin/sh

# Start healthcheck as a background daemon process (it does this itself)
/usr/bin/xyops-healthcheck

# Start nginx in the foreground
exec /usr/sbin/nginx -g 'daemon off;'
