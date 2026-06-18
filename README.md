# xyOps Multi-Master Nginx SSO

This repo generates a custom Docker Image designed to be used with [xyOps](https://xyops.io).

This is a wrapper around the official [Nginx Docker Image](https://hub.docker.com/_/nginx), which layers in [Node.js](https://nodejs.org/) and a custom [Health Check Daemon](https://github.com/pixlcore/xyops-healthcheck) for [xyOps](https://xyops.io).  This is for use with xyOps multi-master setups, using [OAuth2-Proxy](https://github.com/oauth2-proxy/oauth2-proxy) for SSO integration.  Plain HTTP is available on port 80 for local testing, and HTTPS is always enabled on port 443 using default self-signed certs.  For setup instructions, please see the [xyOps SSO Setup Guide](https://docs.xyops.io/sso).

## Current Versions

- Nginx v1.30
- Node.js v24
- Health Check v1.0.5

# Usage

## Docker

This repo automatically publishes a Docker image on every tag, which is designed to run with [Nginx](https://nginx.org/) for xyOps multi-master installs.  For usage instructions, see the [xyOps SSO Setup Guide](https://docs.xyops.io/sso).  The Docker Image name is:

```
ghcr.io/pixlcore/xyops-nginx-sso
```

Example use:

```yaml
services:
  nginx:
    image: ghcr.io/pixlcore/xyops-nginx-sso:latest
    depends_on:
      - oauth2-proxy
    init: true
    environment:
      XYOPS_masters: xyops01.yourcompany.com,xyops02.yourcompany.com
      XYOPS_port: 5522
    volumes:
      - "./tls.crt:/etc/tls.crt:ro"
      - "./tls.key:/etc/tls.key:ro"
    ports:
      - "80:80"
      - "443:443"
    networks:
      xyops-net:

  oauth2-proxy:
    image: quay.io/oauth2-proxy/oauth2-proxy:latest
    ...
```

For local testing, you may omit the TLS volume mounts.  The image includes default self-signed certs at `/etc/tls.crt` and `/etc/tls.key`, and production certs can overwrite them by mounting files at those same paths.

# License

**The MIT License (MIT)**

*Copyright (c) 2025 - 2026 PixlCore LLC.*

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
