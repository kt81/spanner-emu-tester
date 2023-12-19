FROM golang:1.21-alpine3.19

WORKDIR /go/src/app
COPY app /go/src/app

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go install github.com/cloudspannerecosystem/spanner-cli@latest \
    && go mod tidy && go build -o /usr/local/bin/spanner-tester
