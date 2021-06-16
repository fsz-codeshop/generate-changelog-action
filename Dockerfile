FROM node:lts-alpine3.13

LABEL org.opencontainers.image.source="https://github.com/ScottBrenner/generate-changelog-action"

RUN apk --no-cache add git
RUN npm install -g generate-changelog

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
