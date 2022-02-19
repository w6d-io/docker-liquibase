FROM liquibase/liquibase:4.7

ARG VCS_REF
ARG BUILD_DATE
ARG VERSION
ARG YQ_VERSION=v4.20.1
ARG USER_EMAIL="david.alexandre@w6d.io"
ARG USER_NAME="David ALEXANDRE"
LABEL maintainer="${USER_NAME} <${USER_EMAIL}>" \
        io.w6d.vcs-ref=$VCS_REF \
        io.w6d.vcs-url="https://github.com/w6d-io/docker-liquibase" \
        io.w6d.build-date=$BUILD_DATE \
        io.w6d.version=$VERSION

USER 0

RUN export PATH="/usr/local/sbt/bin:$PATH" \
    && apt update && apt install -y \
    git                             \
    curl                            \
    jq                              \
    wget                            \
    postgresql-client               \
    && rm -rf /var/lib/apt/lists/*  \
    && wget -O - https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64.tar.gz | tar xz \
    && mv yq_linux_amd64 /usr/bin/yq

USER 1001
