import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Cấu hình ScreenUtil cho toàn bộ ứng dụng
///
/// Sử dụng design size cho màn hình mẫu trong thiết kế
/// Thông thường thiết kế UI được thực hiện trên kích thước cụ thể
class AppScreenUtil {
  // Kích thước thiết kế gốc (px)
  static const double designWidth = 375;
  static const double designHeight = 812;
  
  // Giới hạn điều chỉnh tỷ lệ
  static const double minTextAdapt = 1;
  static const double minWidth = 320;
  static const double maxWidth = 1080;
  
  /// Khởi tạo ScreenUtil với các tham số mặc định
  static ScreenUtilInit init({required Widget child}) {
    return ScreenUtilInit(
      // Kích thước thiết kế chuẩn (thường là size của design Figma/XD)
      designSize: const Size(designWidth, designHeight),
      
      // Điều chỉnh tỷ lệ font chữ theo màn hình
      minTextAdapt: true,
      
      // Giới hạn responsive để tránh biến dạng trên màn hình quá lớn/nhỏ
      splitScreenMode: true,
      
      // Chế độ xây dựng: builder hoặc child
      // Sử dụng builder sẽ đảm bảo ScreenUtil đã được khởi tạo
      builder: (context, child) => child!,
      
      child: child,
    );
  }
  
  /// Báo cáo thông tin màn hình và tỷ lệ
  static void reportScreenInfo(BuildContext context) {
    debugPrint('💡 ScreenUtil Info:');
    debugPrint('📱 Device width: ${ScreenUtil().screenWidth}px');
    debugPrint('📱 Device height: ${ScreenUtil().screenHeight}px');
    debugPrint('📊 Device pixel ratio: ${ScreenUtil().pixelRatio}');
    debugPrint('⚖️ Width scale: ${ScreenUtil().scaleWidth}');
    debugPrint('⚖️ Height scale: ${ScreenUtil().scaleHeight}');
    debugPrint('⚖️ Text scale factor: ${ScreenUtil().textScaleFactor}');
  }
}

/// Extension cho các giá trị số để tính toán kích thước thích ứng nâng cao
/// Bổ sung thêm các phương thức không có trong package gốc
extension AppNumExtension on num {
  /// Điều chỉnh kích thước dựa trên chiều rộng và cao của màn hình
  /// Giúp bạn có được kích thước thích ứng với cả chiều rộng và chiều cao
  double get adaptSize => ScreenUtil().screenWidth < 600 ? w : h;
  
  /// Kích thước min giữa w và h
  double get minSize => w < h ? w : h;
  
  /// Kích thước max giữa w và h
  double get maxSize => w > h ? w : h;
  
  /// Tính toán kích thước tỷ lệ theo cả chiều rộng và chiều cao
  /// weight cho phép điều chỉnh tỷ trọng giữa chiều rộng và chiều cao
  /// weight = 0.5 nghĩa là 50% chiều rộng, 50% chiều cao
  double balanced([double weight = 0.5]) => 
      (w * weight) + (h * (1 - weight));
}

/// Extension cho EdgeInsets để tạo responsive padding và margin
extension AppEdgeInsetsExtension on EdgeInsets {
  /// Tạo EdgeInsets responsive
  EdgeInsets get responsive => EdgeInsets.only(
    top: top.h,
    bottom: bottom.h,
    left: left.w,
    right: right.w,
  );
  
  /// Tạo EdgeInsets responsive với tỷ lệ thích ứng hỗn hợp
  EdgeInsets get adaptiveInsets => EdgeInsets.only(
    top: top.adaptSize,
    bottom: bottom.adaptSize,
    left: left.adaptSize,
    right: right.adaptSize,
  );
}

/// Extension cho context để dễ dàng truy cập kích thước và orientation
extension AppScreenContextExtension on BuildContext {
  /// Chiều rộng màn hình
  double get screenWidth => ScreenUtil().screenWidth;

  /// Chiều cao màn hình
  double get screenHeight => ScreenUtil().screenHeight;
  
  /// Kiểm tra nếu thiết bị là tablet (màn hình lớn)
  bool get isTablet => screenWidth >= 600;
  
  /// Kiểm tra nếu thiết bị là điện thoại (màn hình nhỏ)
  bool get isPhone => screenWidth < 600;
  
  /// Kiểm tra nếu thiết bị đang ở chế độ ngang
  bool get isLandscape => 
      MediaQuery.of(this).orientation == Orientation.landscape;
      
  /// Kiểm tra nếu thiết bị đang ở chế độ dọc
  bool get isPortrait => 
      MediaQuery.of(this).orientation == Orientation.portrait;
} 