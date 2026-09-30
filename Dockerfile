FROM ghcr.io/mhsanaei/3x-ui:latest

# اکسپوز کردن پورت مدیریت پنل
EXPOSE 2053

# اجرای پنل
CMD ["/app/x-ui"]
