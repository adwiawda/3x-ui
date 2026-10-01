FROM alpine:3.19

# نسخه سنایی دلخواه (قابل تغییر در Variables یا هنگام بیلد)
ARG XUI_VERSION=v2.5.8
ARG ARCH=amd64

# نصب پکیج‌های ضروری و Nginx
RUN apk add --no-cache \
    curl \
    bash \
    ca-certificates \
    tzdata \
    sqlite \
    nginx \
    gettext \
    && ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime

# دانلود نسخه سنایی مشخص شده
RUN curl -L "https://github.com/mhsanaei/3x-ui/releases/download/${XUI_VERSION}/x-ui-linux-${ARCH}.tar.gz" -o /tmp/x-ui.tar.gz \
    && tar -xzf /tmp/x-ui.tar.gz -C /usr/local/ \
    && rm /tmp/x-ui.tar.gz \
    && chmod +x /usr/local/x-ui/x-ui \
    && chmod +x /usr/local/x-ui/x-ui.sh \
    && chmod +x /usr/local/x-ui/bin/xray-linux-${ARCH}

RUN mkdir -p /etc/x-ui /var/log/x-ui

# کپی تنظیمات Nginx و اسکریپت استارت
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY start.sh /start.sh
RUN chmod +x /start.sh

# اکسپوز پورت‌های وب‌پنل (2053) و ساب‌سرور (2096)
EXPOSE 2053
EXPOSE 2096

CMD ["/start.sh"]
