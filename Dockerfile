FROM alpine:3.12 as dev
RUN apk add --no-cache go make musl-dev
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

FROM dev as prod-build
WORKDIR $GOPATH/src/github.com/dicksontung/ok
COPY . .
RUN make

FROM scratch as prod

COPY --from=prod-build /go/src/github.com/dicksontung/ok/ok /ok
CMD ["/ok"]
EXPOSE 8888
