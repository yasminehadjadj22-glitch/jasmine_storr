# نشر الموقع على الإنترنت 🚀

## نظرة عامة

هذا الدليل يشرح كيفية نشر نظام إدارة المبيعات والمشتريات على الإنترنت باستخدام **Vercel** (مجاني).

بعد النشر، سيكون الموقع:
- ✅ متاح 24/7 على الإنترنت
- ✅ يعمل على أي جهاز (كمبيوتر، هاتف، تابلت)
- ✅ لا يحتاج لتشغيل الكمبيوتر
- ✅ سريع وآمن مع HTTPS

---

## المتطلبات الأساسية

### 1. حساب GitHub (مجاني)
- إذا لم يكن لديك حساب، سجل على: https://github.com/signup

### 2. حساب Vercel (مجاني)
- سجل على: https://vercel.com/signup
- اختر "Continue with GitHub" للربط مع GitHub

---

## طريقة النشر

### الطريقة 1: النشر عبر GitHub (موصى بها)

#### الخطوة 1: رفع المشروع على GitHub

```bash
# 1. افتح Terminal/Command Prompt في مجلد المشروع
cd /workspace/app-bchw39iq1hc2

# 2. إنشاء مستودع Git محلي
git init

# 3. إضافة جميع الملفات
git add .

# 4. إنشاء أول commit
git commit -m "Initial commit - Sales Management System"

# 5. إنشاء مستودع جديد على GitHub
# اذهب إلى: https://github.com/new
# اسم المستودع: sales-management-system
# اجعله Private (خاص)
# لا تضف README أو .gitignore

# 6. ربط المستودع المحلي مع GitHub
git remote add origin https://github.com/YOUR_USERNAME/sales-management-system.git

# 7. رفع الملفات
git branch -M main
git push -u origin main
```

#### الخطوة 2: النشر على Vercel

1. **اذهب إلى Vercel Dashboard**
   - https://vercel.com/dashboard

2. **اضغط "Add New Project"**

3. **اختر المستودع من GitHub**
   - ابحث عن `sales-management-system`
   - اضغط "Import"

4. **إعداد المشروع**
   - **Framework Preset**: Vite
   - **Root Directory**: `./` (اتركه كما هو)
   - **Build Command**: `npm run build:prod`
   - **Output Directory**: `dist`

5. **إضافة متغيرات البيئة (Environment Variables)**
   
   اضغط على "Environment Variables" وأضف:
   
   ```
   VITE_SUPABASE_URL=https://iwplybmddexrcibustci.supabase.co
   VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml3cGx5Ym1kZGV4cmNpYnVzdGNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc2NDU5OTgsImV4cCI6MjA5MzIyMTk5OH0.-e_Q-aLzcEQ6E6qJLwhDhhObC_L-KN5u2hbFT7ejl9k
   ```

6. **اضغط "Deploy"**
   - انتظر 2-3 دقائق حتى يكتمل النشر

7. **احصل على الرابط**
   - بعد اكتمال النشر، ستحصل على رابط مثل:
   - `https://sales-management-system.vercel.app`

---

### الطريقة 2: النشر المباشر عبر Vercel CLI

```bash
# 1. تثبيت Vercel CLI
npm install -g vercel

# 2. تسجيل الدخول
vercel login

# 3. الانتقال لمجلد المشروع
cd /workspace/app-bchw39iq1hc2

# 4. النشر
vercel --prod

# 5. اتبع التعليمات:
# - Set up and deploy? Yes
# - Which scope? (اختر حسابك)
# - Link to existing project? No
# - What's your project's name? sales-management-system
# - In which directory is your code located? ./
# - Want to override the settings? No

# 6. أضف متغيرات البيئة عبر Dashboard
# https://vercel.com/YOUR_USERNAME/sales-management-system/settings/environment-variables
```

---

## إعدادات مهمة بعد النشر

### 1. تحديث Supabase Redirect URLs

اذهب إلى Supabase Dashboard:
1. افتح مشروعك: https://supabase.com/dashboard/project/iwplybmddexrcibustci
2. اذهب إلى **Authentication** → **URL Configuration**
3. أضف رابط Vercel إلى **Site URL**:
   ```
   https://your-app-name.vercel.app
   ```
4. أضف رابط Vercel إلى **Redirect URLs**:
   ```
   https://your-app-name.vercel.app/**
   ```

### 2. تخصيص النطاق (اختياري)

إذا كان لديك نطاق خاص (مثل: mystore.com):
1. اذهب إلى Vercel Dashboard
2. اختر المشروع → **Settings** → **Domains**
3. أضف نطاقك واتبع التعليمات

---

## التحديثات المستقبلية

### إذا استخدمت GitHub:
```bash
# 1. عدل الملفات كما تريد
# 2. احفظ التغييرات
git add .
git commit -m "وصف التحديث"
git push

# Vercel سيقوم بالنشر تلقائياً!
```

### إذا استخدمت Vercel CLI:
```bash
# في مجلد المشروع
vercel --prod
```

---

## استكشاف الأخطاء

### خطأ: "Build failed"
- تأكد من إضافة متغيرات البيئة في Vercel
- تحقق من أن Build Command هو: `npm run build:prod`

### خطأ: "Page not found" عند التنقل
- تأكد من وجود ملف `vercel.json` في المشروع
- تحقق من إعدادات rewrites في vercel.json

### خطأ: "Supabase connection failed"
- تأكد من إضافة `VITE_SUPABASE_URL` و `VITE_SUPABASE_ANON_KEY`
- تحقق من تحديث Redirect URLs في Supabase

### الموقع بطيء
- Vercel مجاني وسريع جداً
- إذا كان بطيئاً، تحقق من اتصال الإنترنت

---

## الأمان

### ✅ آمن:
- متغيرات البيئة محمية في Vercel
- HTTPS تلقائي
- قاعدة البيانات محمية بـ RLS (Row Level Security)

### ⚠️ مهم:
- **لا تشارك** ملف `.env` مع أحد
- **لا ترفع** ملف `.env` على GitHub
- استخدم Environment Variables في Vercel فقط

---

## الدعم

### Vercel Documentation
- https://vercel.com/docs

### Supabase Documentation
- https://supabase.com/docs

### مشاكل شائعة
- https://vercel.com/guides

---

## ملاحظات

### التكلفة
- ✅ **مجاني تماماً** للمشاريع الصغيرة
- Vercel Free Plan يشمل:
  - 100 GB Bandwidth شهرياً
  - نشر غير محدود
  - HTTPS مجاني
  - نطاق فرعي مجاني (.vercel.app)

### الأداء
- ⚡ سريع جداً (CDN عالمي)
- 🌍 متاح في جميع أنحاء العالم
- 📱 يعمل على جميع الأجهزة

### النسخ الاحتياطي
- 🔄 Vercel يحتفظ بجميع النسخ السابقة
- يمكنك الرجوع لأي نسخة قديمة بضغطة زر

---

## الخلاصة

بعد اتباع هذه الخطوات، سيكون موقعك:
- 🌐 متاح على الإنترنت 24/7
- 📱 يعمل على الهاتف والكمبيوتر
- 🔒 آمن مع HTTPS
- ⚡ سريع جداً
- 💰 مجاني تماماً

**رابط الموقع سيكون مثل:**
```
https://sales-management-system.vercel.app
```

**يمكنك مشاركة هذا الرابط مع أي شخص!**

---

**تاريخ الإنشاء**: 2026-05-01
**الإصدار**: v10
