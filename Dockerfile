FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.* ./

RUN go mod download

COPY . .

RUN go build -o main cmd/main.go

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/main cmd/

EXPOSE 8080

CMD ["cmd/main"]