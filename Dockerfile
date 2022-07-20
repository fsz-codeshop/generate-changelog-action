#FROM alpine:3
FROM node:lts-alpine

LABEL org.opencontainers.image.source="https://github.com/ScottBrenner/generate-changelog-action"

#RUN apk --no-cache --update add git npm
RUN npm install -g generate-changelog

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
