# ملخص سريع للنشر 🚀

## الخطوات الأساسية (5 دقائق)

### 1️⃣ إنشاء حساب Vercel
- اذهب إلى: https://vercel.com/signup
- سجل باستخدام GitHub أو Email

### 2️⃣ تثبيت Vercel CLI
```bash
npm install -g vercel
```

### 3️⃣ تسجيل الدخول
```bash
vercel login
```

### 4️⃣ النشر
```bash
cd /workspace/app-bchw39iq1hc2
vercel --prod
```

### 5️⃣ إضافة متغيرات البيئة
في Vercel Dashboard، أضف:
```
VITE_SUPABASE_URL=https://iwplybmddexrcibustci.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml3cGx5Ym1kZGV4cmNpYnVzdGNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc2NDU5OTgsImV4cCI6MjA5MzIyMTk5OH0.-e_Q-aLzcEQ6E6qJLwhDhhObC_L-KN5u2hbFT7ejl9k
```

---

## أو استخدم السكريبت الجاهز

### Windows:
```cmd
deploy.bat
```

### Mac/Linux:
```bash
./deploy.sh
```

---

## بعد النشر

### تحديث Supabase
1. اذهب إلى: https://supabase.com/dashboard/project/iwplybmddexrcibustci
2. Authentication → URL Configuration
3. أضف رابط Vercel إلى Site URL و Redirect URLs

---

## الرابط النهائي
بعد النشر، ستحصل على رابط مثل:
```
https://your-app-name.vercel.app
```

**شارك هذا الرابط مع أي شخص!** 📱💻

---

للتفاصيل الكاملة، راجع: **DEPLOYMENT_GUIDE.md**
