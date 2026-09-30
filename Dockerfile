FROM ghcr.io/mhsanaei/3x-ui:latest

# اکسپوز کردن پورت وب‌پنل (2053) و پورت ساب‌سرور (2096)
EXPOSE 2053
EXPOSE 2096

CMD ["/app/x-ui"]
