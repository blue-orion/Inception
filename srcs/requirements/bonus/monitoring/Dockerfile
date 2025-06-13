FROM alpine:3.21

RUN apk update && \
  apk add --no-cache \
  git \
  nodejs  \
  npm \
  python3 \
  make  \
  g++ \
  bash  \
  curl

WORKDIR /app

RUN git clone https://github.com/louislam/uptime-kuma.git .

COPY conf/kuma.db /app/data/kuma.db

RUN npm install

RUN npm run build

EXPOSE 3001

CMD ["node", "server/server.js"]
