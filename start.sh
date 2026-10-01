#!/bin/bash

# تنظیم پورت پیش‌فرض در صورت عدم دریافت متغیر از Railway
export PORT=${PORT:-8080}

# جایگزینی متغیر PORT در کانفیگ Nginx
envsubst '${PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# اجرای Nginx
nginx

# اجرای پنل 3x-ui
cd /usr/local/x-ui
./x-ui
