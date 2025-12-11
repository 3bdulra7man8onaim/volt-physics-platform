# منصة الفولت في الفيزياء - Dockerfile
# تطوير: Abdulrahman Ghonaim

# استخدام Node.js كصورة أساسية
FROM node:18-alpine AS builder

# تعيين مجلد العمل
WORKDIR /app

# نسخ ملفات package
COPY package*.json ./

# تثبيت التبعيات
RUN npm ci --only=production && npm cache clean --force

# نسخ كود المصدر
COPY . .

# بناء التطبيق للإنتاج
RUN npm run build

# مرحلة الإنتاج
FROM nginx:alpine AS production

# تثبيت الأدوات المطلوبة
RUN apk add --no-cache curl

# نسخ ملفات البناء
COPY --from=builder /app/build /usr/share/nginx/html

# نسخ إعدادات Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# إنشاء مستخدم غير جذر
RUN addgroup -g 1001 -S nodejs && \
    adduser -S volt -u 1001 -G nodejs

# تعيين الصلاحيات
RUN chown -R volt:nodejs /usr/share/nginx/html && \
    chown -R volt:nodejs /var/cache/nginx && \
    chown -R volt:nodejs /var/log/nginx && \
    chown -R volt:nodejs /etc/nginx/conf.d

# التبديل للمستخدم غير الجذر
USER volt

# كشف المنفذ
EXPOSE 80

# فحص صحة التطبيق
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# تشغيل Nginx
CMD ["nginx", "-g", "daemon off;"]

# إضافة معلومات التطبيق
LABEL maintainer="Abdulrahman Ghonaim <abdulrahman.ghonaim@gmail.com>"
LABEL description="منصة الفولت في الفيزياء - مستر السيد محمد"
LABEL version="1.0.0"
LABEL org.opencontainers.image.source="https://github.com/3bdulra7man8onaim/volt-physics-platform"