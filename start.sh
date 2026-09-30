#!/bin/bash

# جایگزینی متغیر PORT در فایل تنظیمات Nginx
envsubst '${PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# اجرای Nginx در پس‌زمینه
nginx

# اجرای پنل 3x-ui
cd /usr/local/x-ui
./x-ui
