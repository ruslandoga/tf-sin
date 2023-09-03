imgproxy

```console
$ docker run -d --restart always --network host --name imgproxy \
  -e IMGPROXY_LOG_LEVEL=warn \
  -e IMGPROXY_MAX_SRC_RESOLUTION=100 \
  -e IMGPROXY_JPEG_PROGRESSIVE=true \
  -e "IMGPROXY_ALLOWED_SOURCES=${USER_CDN}/" \
  -e "IMGPROXY_KEY=${IMGPROXY_KEY}" \
  -e "IMGPROXY_SALT=${IMGPROXY_SALT}" \
   darthsim/imgproxy:v2
```

caddy

```Caffydile
{
  admin 127.0.0.1:2019
}

b-do.getsince.app {
  reverse_proxy localhost:4000
}

seeing-do.getsince.app {
  reverse_proxy localhost:8080
}
```

```console
$ docker run -d --restart always --network host --name caddy \
  -v $PWD/Caddyfile:/etc/caddy/Caddyfile \
  -v caddy_data:/data \
  caddy:2-alpine
```

test3

```console
$ LOCAL_IPV4=$(curl http://169.254.169.254/metadata/v1/interfaces/private/0/ipv4/address)
$ docker run -d --restart always --network host --name test3 \
  -e PHX_SERVER=true -e PORT=4000 -e "HOST=b.getsince.app" -e "CHECK_ORIGIN=//*.getsince.app" -e "SECRET_KEY_BASE=${SECRET_KEY_BASE}" \
  -e ERL_MAX_PORTS=1024 \
  -e RELEASE_DISTRIBUTION=name -e "RELEASE_NODE=t@${LOCAL_IPV4}" -e "RELEASE_COOKIE=${RELEASE_COOKIE}" -e "PRIMARY_HOST_PREFIX=10.0.1." \
  -e "DIGITALOCEAN_API_TOKEN=${DIGITALOCEAN_API_TOKEN}" \
  -e "DATABASE_URL=${DATABASE_URL}" \
  -e "DASHBOARD_USERNAME=${DASHBOARD_USERNAME}" -e "DASHBOARD_PASSWORD=${DASHBOARD_PASSWORD}" \
  -e "IMGPROXY_PREFIX=${IMGPROXY_PREFIX}" -e "IMGPROXY_KEY=${IMGPROXY_KEY}" -e "IMGPROXY_SALT=${IMGPROXY_SALT}" \
  -e "MAXMIND_LICENSE_KEY=${MAXMIND_LICENSE_KEY}" \
  -e "TG_BOT_KEY=${TG_BOT_KEY}" -e "TG_ROOM_ID=${TG_ROOM_ID}" \
  -e "SENTRY_DSN=${SENTRY_DSN}" \
  -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
  -e "AWS_S3_BUCKET=${AWS_S3_BUCKET}" -e "USER_CDN=${USER_CDN}" \
  -e "AWS_S3_BUCKET_STATIC=${AWS_S3_BUCKET_STATIC}" -e "STATIC_CDN=${STATIC_CDN}" \
  -e "AWS_S3_BUCKET_MEDIA=${AWS_S3_BUCKET_MEDIA}" -e "MEDIA_CDN=${MEDIA_CDN}" \
  -e "AWS_S3_BUCKET_EVENTS=${AWS_S3_BUCKET_EVENTS}" \
  -e "SPOTIFY_CLIENT_ID=${SPOTIFY_CLIENT_ID}" -e "SPOTIFY_CLIENT_SECRET=${SPOTIFY_CLIENT_SECRET}" \
  -e "APNS_TOPIC=${APNS_TOPIC}" -e "APNS_TEAM_ID=${APNS_TEAM_ID}" \
  -e "PROD_APNS_KEY_ID=${PROD_APNS_KEY_ID}" -e "PROD_APNS_KEY=${PROD_APNS_KEY}" \
  -e "SANDBOX_APNS_KEY_ID=${SANDBOX_APNS_KEY_ID}" -e "SANDBOX_APNS_KEY=${SANDBOX_APNS_KEY}" \
  -e "APP_STORE_ISSUER_ID=${APP_STORE_ISSUER_ID}" -e "APP_STORE_KEY_ID=${APP_STORE_KEY_ID}" -e "APP_STORE_KEY=${APP_STORE_KEY}" \
  ghcr.io/getsince/test3:master
```

Re `ERL_MAX_PORTS=1024` see https://elixirforum.com/t/elixir-erlang-docker-containers-ram-usage-on-different-oss-kernels/57251
