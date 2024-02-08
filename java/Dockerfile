ARG NODE_VERSION=20.11.0
ARG CDK8S_CLI_VERSION=2.198.36
ARG ALPINE_VERSION=3.15

FROM --platform=${BUILDPLATFORM} node:${NODE_VERSION}-alpine as node

FROM alpine:${ALPINE_VERSION}

USER root

RUN addgroup -g 1000 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

RUN apk add --no-cache \
    openjdk11 \
    maven

RUN npm install -g cdk8s-cli@${CDK8S_CLI_VERSION}

USER argocd

WORKDIR /home/argocd
