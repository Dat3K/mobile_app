import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Ví dụ 1: Sử dụng ScreenUtil trong responsive UI
/// Card thông tin người dùng responsive
class ResponsiveUserCard extends StatelessWidget {
  final String name;
  final String role;
  final String avatarUrl;
  final VoidCallback onTap;

  const ResponsiveUserCard({
    super.key,
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Kiểm tra nếu đang ở chế độ ngang
    final bool isLandscape = 
        MediaQuery.of(context).orientation == Orientation.landscape;
    
    // Điều chỉnh kích thước dựa vào orientation và kích thước màn hình
    final double cardWidth = isLandscape ? 300.w : 0.9.sw;
    final double cardHeight = 120.h;
    final double avatarSize = 70.sp;
    final double nameSize = 16.sp;
    final double roleSize = 14.sp;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: avatarSize / 2,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            SizedBox(width: 16.w),
            
            // Thông tin người dùng
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: nameSize,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    role,
                    style: TextStyle(
                      fontSize: roleSize,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            // Icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

/// Ví dụ 2: Sử dụng ScreenUtil cho responsive Grid
/// Grid hiển thị danh sách khóa học
class ResponsiveCourseGrid extends StatelessWidget {
  final List<Map<String, dynamic>> courses;

  const ResponsiveCourseGrid({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    // Quyết định số cột dựa vào kích thước màn hình
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;
    
    // Responsive grid
    if (screenWidth < 600) {
      crossAxisCount = 2; // Điện thoại
    } else if (screenWidth < 900) {
      crossAxisCount = 3; // Tablet nhỏ
    } else {
      crossAxisCount = 4; // Tablet lớn/Desktop
    }

    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return _buildCourseCard(course);
      },
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh khóa học
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.network(
              course['imageUrl'] as String,
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Nội dung
          Padding(
            padding: EdgeInsets.all(12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['title'] as String,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  course['instructor'] as String,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '${course['rating']}',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Ví dụ 3: Sử dụng các extensions đã tạo - có một số phương thức tùy chỉnh
/// Lưu ý: Một số extension này yêu cầu import AppScreenContextExtension từ file screen_util_config.dart
class ResponsiveForm extends StatelessWidget {
  const ResponsiveForm({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng MediaQuery thay vì extension nếu extension chưa được định nghĩa
    final bool isPhone = MediaQuery.of(context).size.width < 600;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    // Điều chỉnh layout dựa vào loại thiết bị và orientation
    return Container(
      width: isPhone ? 1.sw : 0.7.sw,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 24.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin cá nhân',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          
          // Điều chỉnh layout dựa vào orientation
          if (isLandscape)
            _buildLandscapeForm()
          else
            _buildPortraitForm(),
        ],
      ),
    );
  }

  Widget _buildPortraitForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Họ và tên'),
        SizedBox(height: 16.h),
        _buildTextField('Email'),
        SizedBox(height: 16.h),
        _buildTextField('Số điện thoại'),
        SizedBox(height: 24.h),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildLandscapeForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField('Họ và tên')),
            SizedBox(width: 16.w),
            Expanded(child: _buildTextField('Email')),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(child: _buildTextField('Số điện thoại')),
            SizedBox(width: 16.w),
            Expanded(child: SizedBox()),
          ],
        ),
        SizedBox(height: 24.h),
        Align(
          alignment: Alignment.centerRight,
          child: _buildSubmitButton(),
        ),
      ],
    );
  }

  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 12.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Text(
        'Lưu thông tin',
        style: TextStyle(fontSize: 16.sp),
      ),
    );
  }
} 