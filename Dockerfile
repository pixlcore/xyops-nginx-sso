FROM nginx:latest

RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y nodejs
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Generate default self-signed TLS certs for local testing.
# These can be overwritten later by mounting real certs at the same paths.
RUN openssl req -x509 -nodes -newkey rsa:2048 -days 3650 \
	-subj "/CN=localhost" \
	-addext "subjectAltName = DNS:localhost,IP:127.0.0.1" \
	-keyout /etc/tls.key \
	-out /etc/tls.crt && \
	chmod 600 /etc/tls.key

WORKDIR /opt/healthcheck
COPY . .

RUN mv nginx.conf /etc/nginx/
RUN mv conf.d/* /etc/nginx/conf.d/

RUN npm install -g @pixlcore/xyops-healthcheck

# Document both supported listener ports in the image metadata.
EXPOSE 80 443

CMD ["sh", "start.sh"]
