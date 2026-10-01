FROM alpine:3.19

ARG XUI_VERSION=v2.4.8
ARG ARCH=amd64

RUN apk add --no-cache \
    curl \
    bash \
    ca-certificates \
    tzdata \
    sqlite \
    && ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime

# دانلود و استخراج پنل 3x-ui
RUN curl -fSL "https://github.com/mhsanaei/3x-ui/releases/download/${XUI_VERSION}/x-ui-linux-${ARCH}.tar.gz" -o /tmp/x-ui.tar.gz \
    && tar -xzf /tmp/x-ui.tar.gz -C /usr/local/ \
    && rm /tmp/x-ui.tar.gz \
    && chmod +x /usr/local/x-ui/x-ui \
    && chmod +x /usr/local/x-ui/x-ui.sh \
    && chmod +x /usr/local/x-ui/bin/xray-linux-${ARCH}

RUN mkdir -p /etc/x-ui /var/log/x-ui

# باز کردن پورت 2096 برای Railway
EXPOSE 2096

# اجرای مستقیم پنل
CMD ["/usr/local/x-ui/x-ui"]
