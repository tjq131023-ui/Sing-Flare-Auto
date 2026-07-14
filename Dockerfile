FROM alpine:latest
RUN apk add --no-cache ca-certificates bash wget tar
WORKDIR /app
RUN wget https://github.com/SagerNet/sing-box/releases/download/v1.10.1/sing-box-1.10.1-linux-amd64.tar.gz && \
    tar -zxvf sing-box-1.10.1-linux-amd64.tar.gz && \
    mv sing-box-1.10.1-linux-amd64/sing-box /usr/local/bin/sing-box && \
    rm -rf sing-box-1.10.1-linux-amd64*
RUN wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
COPY . .
RUN chmod +x /usr/local/bin/sing-box && \
    chmod +x /usr/local/bin/cloudflared && \
    chmod +x start.sh
EXPOSE 8080
CMD ["./start.sh"]
