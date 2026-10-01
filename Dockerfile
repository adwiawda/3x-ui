FROM alpine:3.19

# تعیین نسخه سنایی (قابل تغییر از طریق Railway Variables)
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

# دانلود مستقیم و استخراج نسخه مشخص شده سنایی
RUN curl -L "https://github.com/mhsanaei/3x-ui/releases/download/${XUI_VERSION}/x-ui-linux-${ARCH}.tar.gz" -o /tmp/x-ui.tar.gz \
    && tar -xzf /tmp/x-ui.tar.gz -C /usr/local/ \
    && rm /tmp/x-ui.tar.gz \
    && chmod +x /usr/local/x-ui/x-ui \
    && chmod +x /usr/local/x-ui/x-ui.sh \
    && chmod +x /usr/local/x-ui/bin/xray-linux-${ARCH}

# ساخت دایرکتوری‌های مورد نیاز و مسیرهای احتمالی فایل sub.html
RUN mkdir -p /etc/x-ui /var/log/x-ui /usr/local/x-ui/bin/html

# کپی تنظیمات Nginx و فایل متحرک sub.html به مسیرهای اصلی پنل
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY sub.html /usr/local/x-ui/bin/sub.html
COPY sub.html /usr/local/x-ui/sub.html
COPY sub.html /usr/local/x-ui/bin/html/sub.html

EXPOSE 2053
EXPOSE 2096

# اجرای مستقیم Nginx و پنل 3x-ui به‌‌صورت یکپارچه در CMD (بدون نیاز به start.sh)
CMD ["sh", "-c", "export PORT=${PORT:-8080} && envsubst '${PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && nginx && cd /usr/local/x-ui && ./x-ui"]
