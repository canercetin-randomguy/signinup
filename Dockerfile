FROM golang:latest as builder
WORKDIR /bin
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o main .
EXPOSE 4545
CMD ["./main"]
