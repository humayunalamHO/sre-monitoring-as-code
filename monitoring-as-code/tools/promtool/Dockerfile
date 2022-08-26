FROM golang:1.19.0-alpine3.15 AS builder

RUN apk add curl jq

ARG VERSION

#RUN if [ "$ENV" = "production" ] ; then yarn client:build:prod ; else yarn client:build ; fi

#RUN if [ -z "$VERSION" ] ; then VERSION=$(curl -Ls https://api.github.com/repos/prometheus/prometheus/releases/latest | jq ".tag_name" | xargs | cut -c2-) ; fi 
COPY prom.sh /tmp/
RUN chmod u+x /tmp/bash.sh
RUN if [ -z "$VERSION" ] ; then echo "version is empty"; fi


RUN wget -qO- "https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-$VERSION.linux-amd64.tar.gz" \
     | tar xvzf - "prometheus-$VERSION.linux-amd64"/promtool --strip-components=1 && cp promtool /go/bin/promtool


FROM alpine:3.16.2 AS runner

COPY --from=builder /go/bin/promtool /usr/local/bin

RUN promtool --version

ENTRYPOINT [ "/usr/local/bin/promtool" ]
