# Etapa 1: compilación
FROM golang:1.20-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

# Copia todo el proyecto
COPY . .

# Compilación del binario estático
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello-api ./main.go

# Etapa 2: imagen mínima
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/hello-api .

EXPOSE 8080

CMD ["./hello-api"]
