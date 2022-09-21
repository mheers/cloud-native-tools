ARG ALPINE_VERSION

FROM mheers/alpine-tools:${ALPINE_VERSION}

RUN apk add --no-cache \
    bash \
    bind-tools \
    curl \
    git \
    iputils \
    jq \
    nano \
    netcat-openbsd \
    openssh-client
