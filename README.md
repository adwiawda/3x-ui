# 3x-ui Panel on Railway

<p align="center">
  <a href="https://t.me/meov2ray">
    <img src="https://img.shields.io/badge/Telegram-MEOV2RAY-26A5E4?style=for-the-badge&logo=telegram&logoColor=white" alt="Telegram Channel" />
  </a>
  &nbsp;
  <a href="https://youtube.com/@meov2ray">
    <img src="https://img.shields.io/badge/YouTube-MEOV2RAY-FF0000?style=for-the-badge&logo=youtube&logoColor=white" alt="YouTube Channel" />
  </a>
</p>

این پروژه جهت اجرای **پنل مدیریت 3x-ui (پنل سنایی)** بر روی سرویس ابری **Railway** آماده شده است.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/deploy)

---

## 📢 راه‌های ارتباطی و کانال‌های ما

برای دریافت آخرین آموزش‌ها، کانفیگ‌ها و به‌روزرسانی‌ها به کانال‌های ما بپوندید:

* 📢 **کانال تلگرام:** <a href="https://t.me/meov2ray">
    <img src="https://img.shields.io/badge/Telegram-MEOV2RAY-26A5E4?style=for-the-badge&logo=telegram&logoColor=white" alt="Telegram Channel" />
* 🎥 **کانال یوتیوب:**  <a href="https://youtube.com/@meov2ray">
    <img src="https://img.shields.io/badge/YouTube-MEOV2RAY-FF0000?style=for-the-badge&logo=youtube&logoColor=white" alt="YouTube Channel" />

---

## 🚀 راهنمای نصب و راه‌اندازی سریع

### روش اول: دیپلوی مستقیم از طریق گیت‌هاب (پیشنهادی)

1. این ریپازیتوری را **Fork** کنید یا یک ریپازیتوری جدید در حساب گیت‌هاب خود بسازید.
2. فایل‌های `Dockerfile` و `README.md` موجود در این پروژه را داخل ریپازیتوری خود قرار دهید.
3. وارد حساب کاربری خود در railway.app شوید.
4. بر روی **New Project** کلیک کرده و گزینه **Deploy from GitHub repo** را انتخاب کنید.
5. ریپازیتوری ایجاد شده را انتخاب کنید تا فرایند ساخت کانتینر آغاز شود.

---

## ⚙️ تنظیمات مهم در Railway (ضروری)

برای کارکرد صحیح پنل و جلوگیری از پاک شدن اطلاعات، حتماً مراحل زیر را انجام دهید:

### ۱. تنظیم دیتابیس دائم (Persistent Volume)
از آنجا که فایل‌های سرویس‌های Serverless با هر بار ری‌استارت پاک می‌شوند، باید یک Volume برای ذخیره دیتابیس پنل بسازید:
1. در داشبورد پروژه در Railway، بر روی سرویس خود کلیک کنید.
2. به تب **Volumes** بروید و روی **Add Volume** کلیک کنید.
3. مسیر **Mount Path** را برابر با مقدار زیر قرار دهید:
   ```text
   /etc/x-ui
