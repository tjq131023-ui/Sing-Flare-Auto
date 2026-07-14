#!/bin/sh

if [ -z "$PORT" ]; then
  export PORT=8080
fi

if [ -z "$UUID" ]; then
  export UUID="44ff9fab-3a9f-4bcc-9d16-34034cd9bac4"
fi

if [ -z "$WSPATH" ]; then
  export WSPATH="vless"
fi

echo "正在启动 Xray, 监听 PORT: $PORT, UUID: $UUID, WSPATH: $WSPATH"

sed -i "s/UUID_PLACEHOLDER/$UUID/g" ./config.json
sed -i "s/WSPATH_PLACEHOLDER/$WSPATH/g" ./config.json

/usr/local/bin/xray -config ./config.json &

if [ -z "$ARGO_AUTH" ]; then
  echo "错误: 未配置 ARGO_AUTH 环境变量！"
  exit 1
fi

echo "正在启动 cloudflared..."
/usr/local/bin/cloudflared tunnel --no-autoupdate run --token "$ARGO_AUTH"
