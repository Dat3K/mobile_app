# Hướng dẫn sử dụng Flutter ScreenUtil (v5.9.3)

Flutter ScreenUtil là một thư viện giúp tạo giao diện thích ứng (responsive) trong ứng dụng Flutter. Tài liệu này hướng dẫn cách sử dụng ScreenUtil đã được cấu hình trong dự án của chúng ta.

## 📋 Mục lục

- [Giới thiệu](#giới-thiệu)
- [Cấu hình](#cấu-hình)
- [Cách sử dụng cơ bản](#cách-sử-dụng-cơ-bản)
- [Extensions nâng cao](#extensions-nâng-cao)
- [Các trường hợp sử dụng phổ biến](#các-trường-hợp-sử-dụng-phổ-biến)
- [Best Practices](#best-practices)
- [Xử lý lỗi thường gặp](#xử-lý-lỗi-thường-gặp)

## 🌟 Giới thiệu

**Flutter ScreenUtil** giúp ứng dụng hiển thị nhất quán trên nhiều thiết bị với kích thước màn hình khác nhau. Thư viện này hoạt động bằng cách điều chỉnh kích thước UI dựa trên kích thước thiết kế ban đầu và kích thước màn hình thực tế.

**Lợi ích chính:**
- Kích thước UI thích ứng trên mọi thiết bị
- Font chữ tự động điều chỉnh
- Dễ dàng quản lý padding, margin và kích thước widget
- Hỗ trợ portrait và landscape mode

## ⚙️ Cấu hình

Trong dự án, chúng ta đã cấu hình ScreenUtil trong tệp:
`lib/core/config/screen_util_config.dart`

### Thông số chính được cấu hình:

```dart
// Kích thước thiết kế gốc (px)
static const double designWidth = 375;
static const double designHeight = 812;
```

Kích thước trên dựa trên thiết kế gốc (thường được lấy từ Figma/XD). Tất cả các tỷ lệ sẽ được tính toán dựa trên kích thước này.

### Khởi tạo

ScreenUtil được khởi tạo trong `main.dart` như sau:

```dart
// Trong Widget MyApp
return AppScreenUtil.init(
  child: ShadApp.materialRouter(
    // ... các thuộc tính khác
  ),
);
```

## 📱 Cách sử dụng cơ bản

### Các extension chính từ package:flutter_screenutil

Khi sử dụng ScreenUtil, bạn có thể sử dụng các extension sau:

```dart
// Chiều rộng - dựa trên tỷ lệ chiều rộng thiết bị
10.w      // Chiều rộng 10px theo thiết kế

// Chiều cao - dựa trên tỷ lệ chiều cao thiết bị
10.h      // Chiều cao 10px theo thiết kế

// Kích thước font chữ - thích ứng với cả thiết bị
10.sp     // Font size 10px theo thiết kế, thích ứng linh hoạt

// Bán kính - hữu ích cho border radius
10.r      // Bán kính 10px theo thiết kế

// Tỷ lệ theo chiều rộng của màn hình
0.1.sw    // 10% chiều rộng màn hình

// Tỷ lệ theo chiều cao của màn hình
0.1.sh    // 10% chiều cao màn hình
```

### Ví dụ cơ bản:

```dart
Container(
  width: 100.w,
  height: 50.h,
  padding: EdgeInsets.all(10.r),
  child: Text(
    'Hello World',
    style: TextStyle(fontSize: 14.sp),
  ),
);
```

## 🚀 Extensions nâng cao

Ngoài các extension cơ bản, chúng ta đã tạo thêm một số extension nâng cao trong `lib/core/config/screen_util_config.dart`:

```dart
// Điều chỉnh kích thước thích ứng theo cả chiều rộng và cao
10.adaptSize    // Kích thước thích ứng dựa vào loại thiết bị

// Kích thước min giữa w và h
10.minSize      // Lấy giá trị nhỏ hơn giữa 10.w và 10.h

// Kích thước max giữa w và h
10.maxSize      // Lấy giá trị lớn hơn giữa 10.w và 10.h

// Tạo EdgeInsets thích ứng
EdgeInsets.all(10).adaptiveInsets  // Thích ứng với mọi loại màn hình
```

## 💡 Các trường hợp sử dụng phổ biến

### 1. Responsive Card

```dart
Card(
  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  child: Padding(
    padding: EdgeInsets.all(12.sp),
    child: Column(
      children: [
        Text(
          'Tiêu đề',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Nội dung',
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    ),
  ),
);
```

### 2. Grid Layout Responsive

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: context.isPhone ? 2 : 4,  // Sử dụng extension context
    childAspectRatio: 1.5,
    crossAxisSpacing: 10.w,
    mainAxisSpacing: 10.h,
  ),
  // ... builder và các thuộc tính khác
);
```

### 3. Responsive Button

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
    textStyle: TextStyle(fontSize: 16.sp),
  ),
  child: Text('Button'),
);
```

### 4. Kiểm tra loại thiết bị

```dart
if (context.isPhone) {
  // Layout cho điện thoại
} else {
  // Layout cho tablet/desktop
}

if (context.isLandscape) {
  // Layout cho chế độ ngang
} else {
  // Layout cho chế độ dọc
}
```

## 🔍 Best Practices

### Nên làm

✅ **Sử dụng extensions (.w, .h, .sp, .r) cho mọi kích thước**
```dart
Container(width: 100.w, height: 50.h);  // Đúng
```

✅ **Sử dụng .sp cho kích thước chữ**
```dart
Text('Hello', style: TextStyle(fontSize: 16.sp));  // Đúng
```

✅ **Sử dụng .r cho độ cong**
```dart
BorderRadius.circular(8.r);  // Đúng
```

✅ **Sử dụng extension kiểm tra thiết bị để thay đổi layout**
```dart
crossAxisCount: context.isPhone ? 2 : 4;  // Đúng
```

### Không nên làm

❌ **Sử dụng giá trị cố định**
```dart
Container(width: 100, height: 50);  // Sai
```

❌ **Sử dụng .h cho chiều rộng hoặc .w cho chiều cao**
```dart
Container(width: 100.h, height: 50.w);  // Sai
```

❌ **Không sử dụng extension cho các giá trị nhỏ (< 1)**
```dart
opacity: 0.5.w;  // Sai, sử dụng opacity: 0.5 thay thế
```

## 🛠️ Xử lý lỗi thường gặp

### 1. Extension không được tìm thấy

**Lỗi:** `The getter 'w' isn't defined for the type 'int'`

**Giải pháp:** Thêm import:
```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

### 2. Extensions tùy chỉnh không hoạt động

**Lỗi:** `The getter 'adaptSize' isn't defined for the type 'num'`

**Giải pháp:** Thêm import:
```dart
import 'package:mobile_app/core/config/screen_util_config.dart';
```

### 3. ScreenUtil chưa được khởi tạo

**Lỗi:** `ScreenUtil().screenWidth` trả về 0

**Giải pháp:** Đảm bảo rằng widget được bọc trong `AppScreenUtil.init()`

## 📚 Tài liệu tham khảo

- [Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil) - Tài liệu chính thức
- [lib/core/config/screen_util_config.dart](../lib/core/config/screen_util_config.dart) - Cấu hình trong dự án
- [lib/core/config/screen_util_example.dart](../lib/core/config/screen_util_example.dart) - Ví dụ thực tế 