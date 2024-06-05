FROM golang:1.22-alpine

WORKDIR /go/src/app

COPY app/go.sum /go/src/app/go.sum
COPY app/go.mod /go/src/app/go.mod

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go mod download && \
    go install github.com/cloudspannerecosystem/spanner-cli@latest

COPY app /go/src/app

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go build -o /usr/local/bin/spanner-tester
