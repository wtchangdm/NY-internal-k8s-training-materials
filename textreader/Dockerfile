ARG RUNETIME=node:15.14.0-alpine

FROM $RUNETIME
WORKDIR /app
COPY package.json yarn.lock app.js /app/

RUN apk add --no-cache tini
# Tini is now available at /sbin/tini
ENTRYPOINT ["/sbin/tini", "--"]

CMD [ "node", "app.js" ]
