# Etapa 1: build
FROM golang:1.20 as builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . ./
RUN go build -o hello-api

# Etapa 2: run (reemplazamos distroless por una imagen más flexible)
FROM debian:bullseye-slim

WORKDIR /app

COPY --from=builder /app/hello-api .

EXPOSE 8080

ENTRYPOINT ["./hello-api"]
