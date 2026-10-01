FROM alpine:3.19

# تعیین نسخه دلخواه سنایی (قابل تغییر در Railway Variables)
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

# دانلود سورس رسمی سنایی مستقیم از Releases گیت‌هاب
RUN curl -L "https://github.com/mhsanaei/3x-ui/releases/download/${XUI_VERSION}/x-ui-linux-${ARCH}.tar.gz" -o /tmp/x-ui.tar.gz \
    && tar -xzf /tmp/x-ui.tar.gz -C /usr/local/ \
    && rm /tmp/x-ui.tar.gz \
    && chmod +x /usr/local/x-ui/x-ui \
    && chmod +x /usr/local/x-ui/x-ui.sh \
    && chmod +x /usr/local/x-ui/bin/xray-linux-${ARCH}

RUN mkdir -p /etc/x-ui /var/log/x-ui

# کپی تنظیمات Nginx، فایل‌های اجرای سیستم و قالب متحرک ساب
# کپی کردن صفحه متحرک در تمامی مسیرهای احتمالی ساب‌اسکریپشن پنل
COPY sub.html /usr/local/x-ui/bin/sub.html
COPY sub.html /usr/local/x-ui/sub.html
COPY sub.html /usr/local/x-ui/bin/html/sub.html
RUN chmod +x /start.sh

# اکسپوز کردن پورت‌های وب‌سرور و ساب‌سرور
EXPOSE 2053
EXPOSE 2096

CMD ["/start.sh"]
