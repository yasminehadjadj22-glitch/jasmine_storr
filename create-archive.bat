@echo off
REM سكريبت لإنشاء ملف مضغوط من المشروع (Windows)
REM Script to create a compressed archive of the project (Windows)

echo.
echo ========================================
echo    إنشاء ملف مضغوط للمشروع
echo    Creating Project Archive
echo ========================================
echo.

REM اسم الملف المضغوط
set ARCHIVE_NAME=sales-management-system-%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip

echo [INFO] سيتم إنشاء ملف مضغوط باسم:
echo [INFO] Archive will be created with name:
echo %ARCHIVE_NAME%
echo.

REM التحقق من وجود PowerShell
where powershell >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] PowerShell غير متوفر
    echo [ERROR] PowerShell is not available
    pause
    exit /b 1
)

echo [COMPRESS] جاري الضغط... قد يستغرق دقيقة...
echo [COMPRESS] Compressing... This may take a minute...
echo.

REM إنشاء الملف المضغوط باستخدام PowerShell
powershell -Command "& { ^
    $source = 'C:\workspace\app-bchw39iq1hc2'; ^
    $destination = 'C:\workspace\%ARCHIVE_NAME%'; ^
    $exclude = @('node_modules', '.git', 'dist', 'build', '.vercel', '.netlify', 'historical_context.txt', '.env', 'pnpm-lock.yaml', 'package-lock.json', 'yarn.lock'); ^
    Add-Type -Assembly 'System.IO.Compression.FileSystem'; ^
    $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal; ^
    $zip = [System.IO.Compression.ZipFile]::Open($destination, 'Create'); ^
    Get-ChildItem -Path $source -Recurse -File | Where-Object { ^
        $file = $_; ^
        -not ($exclude | Where-Object { $file.FullName -like \"*\$_\*\" }) ^
    } | ForEach-Object { ^
        $relativePath = $_.FullName.Substring($source.Length + 1); ^
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $_.FullName, \"app-bchw39iq1hc2\$relativePath\", $compressionLevel) | Out-Null; ^
    }; ^
    $zip.Dispose(); ^
}"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo [SUCCESS] تم إنشاء الملف المضغوط بنجاح!
    echo [SUCCESS] Archive created successfully!
    echo ========================================
    echo.
    echo اسم الملف: %ARCHIVE_NAME%
    echo File name: %ARCHIVE_NAME%
    echo الموقع: C:\workspace\%ARCHIVE_NAME%
    echo Location: C:\workspace\%ARCHIVE_NAME%
    echo.
    
    REM حساب حجم الملف
    for %%A in ("C:\workspace\%ARCHIVE_NAME%") do (
        set SIZE=%%~zA
    )
    echo الحجم: %SIZE% bytes
    echo Size: %SIZE% bytes
    echo.
    echo يمكنك الآن تحميل الملف ومشاركته!
    echo You can now download and share the file!
    echo ========================================
) else (
    echo.
    echo ========================================
    echo [ERROR] فشل إنشاء الملف المضغوط
    echo [ERROR] Failed to create archive
    echo ========================================
    echo.
    echo نصيحة: يمكنك ضغط المجلد يدوياً:
    echo Tip: You can compress the folder manually:
    echo 1. افتح مجلد C:\workspace
    echo    Open folder C:\workspace
    echo 2. انقر بزر الماوس الأيمن على app-bchw39iq1hc2
    echo    Right-click on app-bchw39iq1hc2
    echo 3. اختر "Send to" - "Compressed (zipped) folder"
    echo    Choose "Send to" - "Compressed (zipped) folder"
    echo ========================================
)

echo.
pause
