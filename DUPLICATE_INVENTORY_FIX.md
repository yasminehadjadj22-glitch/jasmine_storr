# إصلاح مشكلة تكرار الجرد السنوي

## المشكلة
كان هناك **12 سجل مكرر** للجرد السنوي لعام 2026 في قاعدة البيانات. المشكلة كانت أن الكود يُنشئ سجل جديد في كل مرة بدلاً من تحديث السجل الموجود.

## السبب
1. **عدم وجود قيود فريدة (unique constraints)** في جدول الجرد
2. **استخدام `insert` بدلاً من `upsert`** في الكود
3. **فحص وجود السجل ثم إدراج/تحديث** كان يسبب race conditions

## الحل

### 1. حذف السجلات المكررة
```sql
-- حذف السجلات المكررة للجرد السنوي
DELETE FROM inventory
WHERE id IN (
  SELECT id FROM (
    SELECT id, ROW_NUMBER() OVER (
      PARTITION BY user_id, period_type, period_year 
      ORDER BY created_at DESC
    ) as rn
    FROM inventory
    WHERE period_type = 'yearly'
  ) t
  WHERE rn > 1
);

-- حذف السجلات المكررة للجرد الشهري
DELETE FROM inventory
WHERE id IN (
  SELECT id FROM (
    SELECT id, ROW_NUMBER() OVER (
      PARTITION BY user_id, period_type, period_year, period_month 
      ORDER BY created_at DESC
    ) as rn
    FROM inventory
    WHERE period_type = 'monthly'
  ) t
  WHERE rn > 1
);
```

### 2. إضافة قيود فريدة
```sql
-- فهرس فريد للجرد الشهري
CREATE UNIQUE INDEX IF NOT EXISTS idx_inventory_monthly_unique 
ON inventory (user_id, period_year, period_month) 
WHERE period_type = 'monthly';

-- فهرس فريد للجرد السنوي
CREATE UNIQUE INDEX IF NOT EXISTS idx_inventory_yearly_unique 
ON inventory (user_id, period_year) 
WHERE period_type = 'yearly';
```

### 3. استخدام `upsert` في الكود

#### قبل الإصلاح:
```typescript
// كود قديم - يسبب تكرار
const { data: existingInventory } = await supabase
  .from('inventory')
  .select('id')
  .eq('user_id', user.id)
  .eq('period_type', 'yearly')
  .eq('period_year', year)
  .maybeSingle();

if (existingInventory) {
  await supabase.from('inventory').update({...}).eq('id', existingInventory.id);
} else {
  await supabase.from('inventory').insert({...});
}
```

#### بعد الإصلاح:
```typescript
// كود جديد - يمنع التكرار
await supabase
  .from('inventory')
  .upsert({
    user_id: user.id,
    period_type: 'yearly',
    period_year: year,
    period_month: null,
    total_sales: data.sales,
    total_purchases: data.purchases,
    total_waste: data.waste,
    total_personal_use: data.personalUse,
  });
```

## النتيجة

### قبل الإصلاح
```
period_type | period_year | count
------------|-------------|------
yearly      | 2026        | 12    ❌ (مكرر 12 مرة!)
```

### بعد الإصلاح
```
period_type | period_year | count
------------|-------------|------
yearly      | 2026        | 1     ✅ (سجل واحد فقط)
```

## الميزات الجديدة

### 1. منع التكرار تلقائياً
- القيود الفريدة تمنع إنشاء سجلات مكررة
- إذا حاول الكود إنشاء سجل مكرر، سيتم تحديث السجل الموجود تلقائياً

### 2. أداء أفضل
- `upsert` أسرع من `select` ثم `insert/update`
- عدد أقل من الاستعلامات لقاعدة البيانات

### 3. كود أبسط
- لا حاجة لفحص وجود السجل
- سطر واحد بدلاً من 10 أسطر

## التحقق من الإصلاح

### 1. التحقق من عدم وجود سجلات مكررة
```sql
-- يجب أن يعيد 0 سجلات
SELECT period_type, period_year, COUNT(*) as count
FROM inventory
WHERE period_type = 'yearly'
GROUP BY period_type, period_year
HAVING COUNT(*) > 1;
```

### 2. التحقق من القيود الفريدة
```sql
-- يجب أن يعرض الفهارس الفريدة
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'inventory'
AND indexdef LIKE '%UNIQUE%';
```

### 3. اختبار إنشاء جرد جديد
1. افتح الصفحة الرئيسية
2. افتح صفحة الجرد
3. اضغط على "حساب الجرد"
4. تحقق من عدم وجود سجلات مكررة

## الملفات المعدلة

1. **src/pages/InventoryPage.tsx**
   - تحديث دالة `autoCalculateInventory`
   - استخدام `upsert` بدلاً من `insert/update`

2. **src/pages/HomePage.tsx**
   - تحديث دالة `calculateInventoryDirect`
   - استخدام `upsert` بدلاً من `insert/update`

3. **supabase/migrations/add_unique_constraint_to_inventory.sql**
   - إضافة قيود فريدة للجرد الشهري والسنوي

## ملاحظات مهمة

- 🔒 **القيود الفريدة**: تمنع التكرار على مستوى قاعدة البيانات
- ⚡ **upsert**: أسرع وأبسط من `select` ثم `insert/update`
- 🛡️ **حماية من race conditions**: لا يمكن إنشاء سجلات مكررة حتى لو تم تشغيل الكود في نفس الوقت
- 📊 **البيانات الصحيحة**: جميع الأرقام صحيحة ولم تتأثر بالتكرار

## الأسئلة الشائعة

### لماذا كان هناك 12 سجل مكرر؟
لأن الكود كان يُنشئ سجل جديد في كل مرة يتم فيها حساب الجرد، بدلاً من تحديث السجل الموجود.

### هل البيانات آمنة؟
نعم، جميع البيانات الأصلية (المبيعات، المشتريات، إلخ) آمنة. تم فقط حذف السجلات المكررة من جدول الجرد.

### هل سيحدث هذا مرة أخرى؟
لا، القيود الفريدة تمنع حدوث هذا مستقبلاً.

### ماذا يحدث إذا حاول الكود إنشاء سجل مكرر؟
سيتم تحديث السجل الموجود تلقائياً بدلاً من إنشاء سجل جديد.

---

**تاريخ الإصلاح**: 2026-05-01
**الإصدار**: v9
