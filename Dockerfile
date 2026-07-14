FROM alpine:latest
RUN apk add --no-cache ca-certificates bash wget unzip tar
WORKDIR /app
RUN wget https://github.com/XTLS/Xray-core/releases/download/v24.12.18/Xray-linux-64.zip && \
    unzip Xray-linux-64.zip -d xray_temp && \
    mv xray_temp/xray /usr/local/bin/xray && \
    rm -rf Xray-linux-64.zip xray_temp
RUN wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
COPY . .
RUN chmod +x /usr/local/bin/xray && \
    chmod +x /usr/local/bin/cloudflared && \
    chmod +x start.sh
EXPOSE 8080
CMD ["./start.sh"]
