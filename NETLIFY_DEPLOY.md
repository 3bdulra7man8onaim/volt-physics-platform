# 🚀 دليل النشر على Netlify - منصة الفولت في الفيزياء

## 📋 الخطوات السريعة

### 1. إعداد المشروع محلياً
```bash
# استنساخ المشروع
git clone https://github.com/your-username/volt-physics-platform.git
cd volt-physics-platform

# تثبيت التبعيات
npm install

# اختبار محلي
npm start
```

### 2. رفع على GitHub
```bash
# إنشاء repository جديد على GitHub
git init
git add .
git commit -m "Initial commit - منصة الفولت في الفيزياء"
git branch -M main
git remote add origin https://github.com/your-username/volt-physics-platform.git
git push -u origin main
```

### 3. النشر على Netlify

#### الطريقة الأولى: من خلال Git
1. اذهب إلى [netlify.com](https://netlify.com)
2. اضغط "New site from Git"
3. اختر GitHub واربط حسابك
4. اختر repository المشروع
5. إعدادات البناء:
   - **Build command**: `npm run build`
   - **Publish directory**: `build`
   - **Node version**: `18`

#### الطريقة الثانية: رفع مباشر
```bash
# بناء المشروع
npm run build

# رفع مجلد build إلى Netlify مباشرة
# (اسحب وأفلت مجلد build في موقع Netlify)
```

## ⚙️ متغيرات البيئة

في لوحة تحكم Netlify، اذهب إلى:
**Site settings > Environment variables**

أضف المتغيرات التالية:
```
REACT_APP_API_URL=https://api.volt-physics.com
REACT_APP_SITE_URL=https://volt-physics.netlify.app
NODE_VERSION=18
```

## 🌐 إعداد الدومين المخصص

### 1. في Netlify
- اذهب إلى **Domain settings**
- اضغط **Add custom domain**
- أدخل الدومين: `volt-physics.com`

### 2. في مزود الدومين
أضف DNS Records:
```
Type: CNAME
Name: www
Value: your-site-name.netlify.app

Type: A
Name: @
Value: 75.2.60.5
```

## 🔒 إعداد HTTPS

Netlify يوفر SSL مجاناً:
1. اذهب إلى **Domain settings**
2. في قسم **HTTPS**
3. اضغط **Verify DNS configuration**
4. انتظر حتى يتم تفعيل الشهادة

## 📊 إعدادات الأداء

### تفعيل Asset Optimization
في **Build & deploy > Post processing**:
- ✅ Bundle CSS
- ✅ Minify CSS
- ✅ Minify JS
- ✅ Compress images
- ✅ Pretty URLs

### إعداد Headers
الملف `netlify.toml` يحتوي على:
- Security headers
- Cache control
- CORS settings

## 🔧 إعدادات متقدمة

### Netlify Functions
إذا كنت تحتاج backend بسيط:
```javascript
// netlify/functions/api.js
exports.handler = async (event, context) => {
  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Hello from Netlify!" })
  };
};
```

### Netlify Identity
لإدارة المستخدمين:
1. فعّل **Identity** في لوحة التحكم
2. أضف الكود في `public/index.html`:
```html
<script src="https://identity.netlify.com/v1/netlify-identity-widget.js"></script>
```

### Netlify Forms
لاستقبال النماذج:
```html
<form name="contact" method="POST" data-netlify="true">
  <input type="hidden" name="form-name" value="contact" />
  <!-- باقي حقول النموذج -->
</form>
```

## 🚀 النشر التلقائي

### إعداد Webhooks
1. في GitHub: **Settings > Webhooks**
2. أضف Netlify webhook URL
3. اختر events: `push`, `pull_request`

### إعداد Branch Deploys
في Netlify **Build & deploy > Continuous Deployment**:
- **Production branch**: `main`
- **Deploy previews**: `Any pull request`
- **Branch deploys**: `All branches`

## 📱 اختبار الموقع

### URLs للاختبار
- **الإنتاج**: https://volt-physics.netlify.app
- **Preview**: https://deploy-preview-[PR-NUMBER]--volt-physics.netlify.app
- **Branch**: https://[BRANCH-NAME]--volt-physics.netlify.app

### أدوات الاختبار
```bash
# اختبار محلي مع Netlify CLI
npm install -g netlify-cli
netlify dev

# اختبار البناء
netlify build

# نشر يدوي
netlify deploy --prod
```

## 🔍 مراقبة الأداء

### Analytics
فعّل **Netlify Analytics** في لوحة التحكم لمراقبة:
- عدد الزوار
- أداء الصفحات
- مصادر الزيارات

### Monitoring
استخدم أدوات مثل:
- **Lighthouse** للأداء
- **GTmetrix** لسرعة التحميل
- **Pingdom** لمراقبة الـ uptime

## 🆘 حل المشاكل الشائعة

### مشكلة 404 في الروابط
تأكد من وجود ملف `_redirects`:
```
/*    /index.html   200
```

### مشكلة في البناء
تحقق من:
- إصدار Node.js (يجب أن يكون 18+)
- متغيرات البيئة
- أخطاء في الكود

### مشكلة في الخطوط العربية
تأكد من:
- تحميل خط Cairo من Google Fonts
- إعداد `dir="rtl"` في HTML
- CSS للنصوص العربية

## 📞 الدعم

### روابط مفيدة
- [Netlify Docs](https://docs.netlify.com/)
- [React Deployment](https://create-react-app.dev/docs/deployment/)
- [Netlify Community](https://community.netlify.com/)

### المطور
- **الاسم**: Abdulrahman Ghonaim
- **البريد**: abdulrahman.ghonaim@gmail.com
- **GitHub**: [@abdulrahman-ghonaim](https://github.com/abdulrahman-ghonaim)

---

**⚡ منصة الفولت في الفيزياء - جاهزة للانطلاق على Netlify!**