#!/bin/bash

# سكريبت نشر سريع على Vercel
# Quick Deployment Script for Vercel

echo "🚀 بدء عملية النشر على Vercel..."
echo "🚀 Starting Vercel Deployment..."
echo ""

# التحقق من تثبيت Vercel CLI
if ! command -v vercel &> /dev/null
then
    echo "❌ Vercel CLI غير مثبت"
    echo "❌ Vercel CLI is not installed"
    echo ""
    echo "📦 جاري التثبيت..."
    echo "📦 Installing..."
    npm install -g vercel
    echo ""
fi

# التحقق من تسجيل الدخول
echo "🔐 التحقق من تسجيل الدخول..."
echo "🔐 Checking login status..."
vercel whoami &> /dev/null

if [ $? -ne 0 ]; then
    echo "❌ لم تسجل الدخول بعد"
    echo "❌ Not logged in"
    echo ""
    echo "🔑 جاري فتح صفحة تسجيل الدخول..."
    echo "🔑 Opening login page..."
    vercel login
    echo ""
fi

# عرض معلومات المشروع
echo "📋 معلومات المشروع:"
echo "📋 Project Information:"
echo "   - الاسم: نظام إدارة المبيعات والمشتريات"
echo "   - Name: Sales Management System"
echo "   - Framework: React + Vite"
echo "   - Database: Supabase"
echo ""

# سؤال المستخدم
read -p "هل تريد المتابعة مع النشر؟ (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "❌ تم إلغاء النشر"
    echo "❌ Deployment cancelled"
    exit 1
fi

echo ""
echo "🔨 جاري بناء المشروع..."
echo "🔨 Building project..."
npm run build:prod

if [ $? -ne 0 ]; then
    echo "❌ فشل البناء"
    echo "❌ Build failed"
    exit 1
fi

echo ""
echo "☁️  جاري النشر على Vercel..."
echo "☁️  Deploying to Vercel..."
vercel --prod

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ تم النشر بنجاح!"
    echo "✅ Deployment successful!"
    echo ""
    echo "📝 الخطوات التالية:"
    echo "📝 Next steps:"
    echo "   1. افتح رابط الموقع الذي ظهر أعلاه"
    echo "   1. Open the URL shown above"
    echo "   2. أضف متغيرات البيئة في Vercel Dashboard"
    echo "   2. Add environment variables in Vercel Dashboard"
    echo "   3. حدّث Redirect URLs في Supabase"
    echo "   3. Update Redirect URLs in Supabase"
    echo ""
    echo "📖 للمزيد من التفاصيل، راجع DEPLOYMENT_GUIDE.md"
    echo "📖 For more details, see DEPLOYMENT_GUIDE.md"
else
    echo ""
    echo "❌ فشل النشر"
    echo "❌ Deployment failed"
    echo ""
    echo "💡 نصائح:"
    echo "💡 Tips:"
    echo "   - تأكد من اتصالك بالإنترنت"
    echo "   - Make sure you're connected to the internet"
    echo "   - تحقق من تسجيل دخولك"
    echo "   - Check if you're logged in"
    echo "   - راجع DEPLOYMENT_GUIDE.md للمساعدة"
    echo "   - See DEPLOYMENT_GUIDE.md for help"
    exit 1
fi
