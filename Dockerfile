FROM alpine:3.19

ARG XUI_VERSION=v2.5.8
ARG ARCH=amd64

RUN apk add --no-cache \
    curl \
    bash \
    ca-certificates \
    tzdata \
    sqlite \
    nginx \
    gettext \
    && ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime

# دانلود و استخراج پنل سنایی
RUN curl -L "https://github.com/mhsanaei/3x-ui/releases/download/${XUI_VERSION}/x-ui-linux-${ARCH}.tar.gz" -o /tmp/x-ui.tar.gz \
    && tar -xzf /tmp/x-ui.tar.gz -C /usr/local/ \
    && rm /tmp/x-ui.tar.gz \
    && chmod +x /usr/local/x-ui/x-ui \
    && chmod +x /usr/local/x-ui/x-ui.sh \
    && chmod +x /usr/local/x-ui/bin/xray-linux-${ARCH}

RUN mkdir -p /etc/x-ui /var/log/x-ui /usr/share/nginx/html

# کپی کانفیگ Nginx و قالب متحرک sub.html به مسیر Nginx
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY sub.html /usr/share/nginx/html/sub.html

EXPOSE 2053
EXPOSE 2096

CMD ["sh", "-c", "export PORT=${PORT:-8080} && envsubst '${PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && nginx && cd /usr/local/x-ui && ./x-ui"]
