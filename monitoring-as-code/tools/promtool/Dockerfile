FROM golang:1.19.0-alpine3.15 AS builder

RUN apk add curl
RUN apk add jq
RUN VERSION=$(curl -Ls https://api.github.com/repos/prometheus/prometheus/releases/latest | jq ".tag_name" | xargs | cut -c2-) &&  \
     wget -qO- "https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-$VERSION.linux-amd64.tar.gz" \
     | tar xvzf - "prometheus-$VERSION.linux-amd64"/promtool --strip-components=1 && cp promtool /go/bin/promtool

FROM alpine:3.16.1 AS runner
COPY --from=builder /go/bin/promtool /usr/local/bin
RUN mkdir /data
#COPY *rules.yaml /data/

#FROM alpine:3.8
#COPY --from=prometheus /bin/promtool /bin/promtool
#RUN mkdir /data
#COPY monitoring-localhost-recording-rules.yaml /data/
#RUN promtool --version 
ENTRYPOINT [ "/usr/local/bin/promtool" ]
#CMD [ "promtool" ]
