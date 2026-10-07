@echo off
REM سكريبت نشر سريع على Vercel لنظام Windows
REM Quick Deployment Script for Vercel (Windows)

echo.
echo ========================================
echo    نشر نظام إدارة المبيعات والمشتريات
echo    Sales Management System Deployment
echo ========================================
echo.

REM التحقق من تثبيت Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js غير مثبت
    echo [ERROR] Node.js is not installed
    echo.
    echo يرجى تثبيت Node.js من: https://nodejs.org
    echo Please install Node.js from: https://nodejs.org
    pause
    exit /b 1
)

REM التحقق من تثبيت Vercel CLI
where vercel >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [INFO] Vercel CLI غير مثبت
    echo [INFO] Vercel CLI is not installed
    echo.
    echo [INSTALL] جاري التثبيت...
    echo [INSTALL] Installing...
    call npm install -g vercel
    echo.
)

REM التحقق من تسجيل الدخول
echo [CHECK] التحقق من تسجيل الدخول...
echo [CHECK] Checking login status...
call vercel whoami >nul 2>nul

if %ERRORLEVEL% NEQ 0 (
    echo [LOGIN] لم تسجل الدخول بعد
    echo [LOGIN] Not logged in
    echo.
    echo [ACTION] جاري فتح صفحة تسجيل الدخول...
    echo [ACTION] Opening login page...
    call vercel login
    echo.
)

REM عرض معلومات المشروع
echo.
echo ========================================
echo معلومات المشروع / Project Information
echo ========================================
echo الاسم: نظام إدارة المبيعات والمشتريات
echo Name: Sales Management System
echo Framework: React + Vite
echo Database: Supabase
echo ========================================
echo.

REM سؤال المستخدم
set /p CONTINUE="هل تريد المتابعة مع النشر؟ (y/n): "
if /i not "%CONTINUE%"=="y" (
    echo.
    echo [CANCEL] تم إلغاء النشر
    echo [CANCEL] Deployment cancelled
    pause
    exit /b 0
)

echo.
echo [BUILD] جاري بناء المشروع...
echo [BUILD] Building project...
call npm run build:prod

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] فشل البناء
    echo [ERROR] Build failed
    echo.
    pause
    exit /b 1
)

echo.
echo [DEPLOY] جاري النشر على Vercel...
echo [DEPLOY] Deploying to Vercel...
call vercel --prod

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo [SUCCESS] تم النشر بنجاح!
    echo [SUCCESS] Deployment successful!
    echo ========================================
    echo.
    echo الخطوات التالية / Next steps:
    echo 1. افتح رابط الموقع الذي ظهر أعلاه
    echo    Open the URL shown above
    echo.
    echo 2. أضف متغيرات البيئة في Vercel Dashboard:
    echo    Add environment variables in Vercel Dashboard:
    echo    - VITE_SUPABASE_URL
    echo    - VITE_SUPABASE_ANON_KEY
    echo.
    echo 3. حدّث Redirect URLs في Supabase
    echo    Update Redirect URLs in Supabase
    echo.
    echo للمزيد من التفاصيل، راجع DEPLOYMENT_GUIDE.md
    echo For more details, see DEPLOYMENT_GUIDE.md
    echo ========================================
) else (
    echo.
    echo ========================================
    echo [ERROR] فشل النشر
    echo [ERROR] Deployment failed
    echo ========================================
    echo.
    echo نصائح / Tips:
    echo - تأكد من اتصالك بالإنترنت
    echo   Make sure you're connected to the internet
    echo - تحقق من تسجيل دخولك
    echo   Check if you're logged in
    echo - راجع DEPLOYMENT_GUIDE.md للمساعدة
    echo   See DEPLOYMENT_GUIDE.md for help
    echo ========================================
)

echo.
pause
