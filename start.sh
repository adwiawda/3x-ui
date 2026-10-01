#!/bin/bash

# ست کردن پورت پیش‌فرض برای Nginx در صورت عدم تزریق متغیر PORT توسط Railway
export PORT=${PORT:-8080}

# جایگزینی متغیر PORT در تنظیمات Nginx
envsubst '${PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# اجرای Nginx در پس‌زمینه
nginx

# اجرای پنل سنایی
cd /usr/local/x-ui
./x-ui
