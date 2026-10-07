#!/bin/bash

# سكريبت لإنشاء ملف مضغوط من المشروع
# Script to create a compressed archive of the project

echo "📦 إنشاء ملف مضغوط للمشروع..."
echo "📦 Creating project archive..."
echo ""

# اسم الملف المضغوط
ARCHIVE_NAME="sales-management-system-$(date +%Y%m%d).zip"

# التحقق من وجود zip
if ! command -v zip &> /dev/null
then
    echo "❌ أداة zip غير مثبتة"
    echo "❌ zip is not installed"
    echo ""
    echo "على Ubuntu/Debian:"
    echo "sudo apt-get install zip"
    echo ""
    echo "على Mac:"
    echo "brew install zip"
    exit 1
fi

# إنشاء الملف المضغوط
echo "🔨 جاري الضغط..."
echo "🔨 Compressing..."
echo ""

cd /workspace

zip -r "$ARCHIVE_NAME" app-bchw39iq1hc2 \
  -x "*/node_modules/*" \
  -x "*/.git/*" \
  -x "*/dist/*" \
  -x "*/build/*" \
  -x "*/.vercel/*" \
  -x "*/.netlify/*" \
  -x "*/historical_context.txt" \
  -x "*/.env" \
  -x "*/pnpm-lock.yaml" \
  -x "*/package-lock.json" \
  -x "*/yarn.lock"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ تم إنشاء الملف المضغوط بنجاح!"
    echo "✅ Archive created successfully!"
    echo ""
    echo "📁 اسم الملف: $ARCHIVE_NAME"
    echo "📁 File name: $ARCHIVE_NAME"
    echo "📍 الموقع: /workspace/$ARCHIVE_NAME"
    echo "📍 Location: /workspace/$ARCHIVE_NAME"
    echo ""
    
    # حجم الملف
    SIZE=$(du -h "/workspace/$ARCHIVE_NAME" | cut -f1)
    echo "📊 الحجم: $SIZE"
    echo "📊 Size: $SIZE"
    echo ""
    
    echo "✨ يمكنك الآن تحميل الملف ومشاركته!"
    echo "✨ You can now download and share the file!"
else
    echo ""
    echo "❌ فشل إنشاء الملف المضغوط"
    echo "❌ Failed to create archive"
    exit 1
fi
