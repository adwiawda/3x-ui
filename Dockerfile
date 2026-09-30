FROM alpine:3.19

# تعیین نسخه پنل سنایی (هر نسخه‌ای از Releases گیت‌هاب را می‌توانید اینجا بنویسید)
ARG XUI_VERSION=v2.5.8
# تعیین معماری (amd64 برای اکثر سرورهای ابری مثل Railway)
ARG ARCH=amd64

# نصب پکیج‌های ضروری شبکه و سیستم‌عامل
RUN apk add --no-cache \
    curl \
    bash \
    ca-certificates \
    tzdata \
    sqlite \
    && ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime

# دانلود مستقیم نسخه مشخص‌شده سنایی از Release رسمی گیت‌هاب و استخراج آن
RUN curl -L "https://github.com/mhsanaei/3x-ui/releases/download/${XUI_VERSION}/x-ui-linux-${ARCH}.tar.gz" -o /tmp/x-ui.tar.gz \
    && tar -xzf /tmp/x-ui.tar.gz -C /usr/local/ \
    && rm /tmp/x-ui.tar.gz \
    && chmod +x /usr/local/x-ui/x-ui \
    && chmod +x /usr/local/x-ui/x-ui.sh \
    && chmod +x /usr/local/x-ui/bin/xray-linux-${ARCH}

# ساخت مسیرهای دیتابیس و لاگ
RUN mkdir -p /etc/x-ui /var/log/x-ui

WORKDIR /usr/local/x-ui

# اکسپوز پورت اصلی پنل
EXPOSE 2053

# اجرای مستقیم هسته پنل
CMD ["./x-ui"]
