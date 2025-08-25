FROM nginx:latest

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y nodejs
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/healthcheck
COPY . .

RUN mv nginx.conf /etc/nginx/
RUN mv conf.d/* /etc/nginx/conf.d/

RUN npm install -g @pixlcore/xyops-healthcheck

CMD ["sh", "start.sh"]
