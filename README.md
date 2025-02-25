# Mobile App - Ứng dụng Quản lý Học tập

Ứng dụng di động hỗ trợ kết nối sinh viên với cơ sở đào tạo và doanh nghiệp. Phát triển bằng Flutter với kiến trúc sạch (Clean Architecture), đáp ứng các yêu cầu hiệu suất và trải nghiệm người dùng cao cấp.

## 📝 Tổng quan

Dự án này được xây dựng nhằm tạo ra một nền tảng kết nối đa chiều giữa sinh viên và doanh nghiệp. Ứng dụng cung cấp các chức năng quản lý sự kiện, tài liệu và kết nối việc làm, với giao diện người dùng hiện đại và hiệu suất tối ưu.

### Mục tiêu chính:
- Tạo môi trường học tập hiệu quả cho sinh viên
- Kết nối doanh nghiệp với sinh viên tiềm năng
- Xây dựng hệ thống thông báo và sự kiện theo thời gian thực

## 🏗️ Kiến trúc dự án

Dự án tuân theo nguyên tắc Clean Architecture với 3 lớp chính:
- **Domain**: Chứa business logic, entities và use cases độc lập với framework
- **Data**: Quản lý dữ liệu từ các nguồn khác nhau (API, local storage)
- **Presentation**: Hiển thị UI và quản lý trạng thái

### Sơ đồ kiến trúc

```
┌─────────────────────────────────────────────────────────────┐
│                      Presentation Layer                      │
│                                                             │
│  ┌─────────────┐   ┌────────────────┐    ┌──────────────┐  │
│  │     UI      │◄─►│ State (Riverpod)│◄──►│   Providers  │  │
│  └─────────────┘   └────────────────┘    └──────────────┘  │
└────────────────────────────┬────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                        Domain Layer                          │
│                                                             │
│  ┌─────────────┐   ┌────────────────┐    ┌──────────────┐  │
│  │  Entities   │   │    Use Cases   │◄──►│ Repositories │  │
│  └─────────────┘   └────────────────┘    └───Interface──┘  │
└────────────────────────────┬────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                        Data Layer                            │
│                                                             │
│  ┌─────────────┐   ┌────────────────┐    ┌──────────────┐  │
│  │   Models    │◄─►│  Repositories  │◄──►│ Data Sources │  │
│  └─────────────┘   └────────────────┘    └──────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### Cấu trúc thư mục

```
lib/
├── core/                  # Thành phần cốt lõi dùng chung
│   ├── config/            # Cấu hình ứng dụng
│   │   └── env.dart       # Biến môi trường
│   ├── constants/         # Hằng số, đường dẫn, khóa lưu trữ
│   │   ├── route_paths.dart       # Đường dẫn tuyến đường
│   │   ├── storage_keys.dart      # Khóa lưu trữ
│   │   ├── app_constants.dart     # Hằng số chung
│   │   └── hive_type_ids.dart     # ID cho Hive adapters
│   ├── error/             # Xử lý lỗi (failures, exceptions)
│   │   ├── failures.dart          # Các loại lỗi
│   │   ├── exceptions.dart        # Các ngoại lệ
│   │   └── http_error.dart        # Lỗi HTTP
│   ├── network/           # Cấu hình kết nối API
│   │   ├── rest/                  # REST API
│   │   │   ├── dio_client.dart    # Client Dio
│   │   │   └── csrf_interceptor.dart # Xử lý CSRF
│   │   └── graphql/               # GraphQL API
│   │       ├── graphql_client.dart    # Client GraphQL
│   │       └── base_graphql_service.dart # Service GraphQL
│   ├── router/            # Điều hướng (GoRouter)
│   │   └── router.dart            # Cấu hình router
│   ├── services/          # Các dịch vụ
│   │   ├── navigation_service.dart # Dịch vụ điều hướng
│   │   ├── cookie_service.dart    # Quản lý cookie
│   │   └── csrf_token_service.dart # Quản lý CSRF token
│   ├── storage/           # Lưu trữ dữ liệu
│   │   ├── hive_storage.dart      # Lưu trữ Hive
│   │   └── secure_storage.dart    # Lưu trữ dữ liệu bảo mật
│   ├── theme/             # Quản lý giao diện
│   │   ├── app_theme.dart         # Cấu hình theme
│   │   └── app_colors.dart        # Bảng màu
│   ├── usecases/          # Use cases cơ bản
│   │   └── usecase.dart           # Interface use case
│   ├── utils/             # Tiện ích
│   │   └── logger.dart            # Ghi log
│   └── widgets/           # Widgets dùng chung
│       ├── debug_menu.dart        # Menu debug
│       └── error_page.dart        # Trang lỗi
│
├── features/              # Các tính năng theo module
│   ├── auth/              # Xác thực người dùng
│   │   ├── data/                  # Lớp dữ liệu auth
│   │   ├── domain/                # Lớp domain auth
│   │   └── presentation/          # Lớp UI auth
│   ├── student/           # Quản lý sinh viên
│   │   ├── data/                  # Lớp dữ liệu sinh viên
│   │   ├── domain/                # Lớp domain sinh viên
│   │   └── presentation/          # Lớp UI sinh viên
│   ├── enterprise/        # Quản lý doanh nghiệp
│   ├── event/             # Quản lý sự kiện
│   ├── notification/      # Quản lý thông báo
│   └── document/          # Quản lý tài liệu
│
└── main.dart              # Điểm khởi đầu ứng dụng
```

### Kiến trúc chi tiết từng module

Mỗi module tính năng được tổ chức theo 3 lớp của Clean Architecture:

```
feature/
├── data/                  # Lớp dữ liệu
│   ├── datasources/       # Nguồn dữ liệu (local, remote)
│   │   ├── local_data_source.dart  # Nguồn dữ liệu local
│   │   └── remote_data_source.dart # Nguồn dữ liệu từ API
│   ├── models/            # Mô hình dữ liệu
│   │   └── entity_model.dart      # Mô hình chuyển đổi từ JSON
│   └── repositories/      # Triển khai repositories
│       └── repository_impl.dart   # Triển khai interface từ domain
│
├── domain/                # Lớp domain
│   ├── entities/          # Đối tượng miền
│   │   └── entity.dart            # Đối tượng domain
│   ├── repositories/      # Interface repositories
│   │   └── repository.dart        # Interface cho repositories
│   ├── usecases/          # Các trường hợp sử dụng
│   │   ├── create_usecase.dart    # Use case tạo mới
│   │   ├── get_usecase.dart       # Use case lấy dữ liệu
│   │   ├── update_usecase.dart    # Use case cập nhật
│   │   └── delete_usecase.dart    # Use case xóa
│   └── value_objects/     # Đối tượng giá trị
│       └── value_object.dart      # Đối tượng giá trị không thay đổi
│
└── presentation/          # Lớp trình bày
    ├── pages/             # Các trang UI
    │   ├── list_page.dart          # Trang danh sách
    │   ├── detail_page.dart        # Trang chi tiết
    │   └── form_page.dart          # Trang form
    └── providers/         # State management (Riverpod)
        ├── state_provider.dart     # Provider quản lý trạng thái
        ├── notifier_provider.dart  # Provider quản lý thay đổi
        └── usecase_provider.dart   # Provider cho use cases
```

## 🛠️ Công nghệ sử dụng

### State Management
- **Flutter Riverpod**: Framework quản lý trạng thái hiện đại với tính năng provider, dependency override và auto-dispose
- **Riverpod Annotations**: Tạo code tự động cho providers với annotation
- **Hooks Riverpod**: Kết hợp Flutter Hooks với Riverpod
- **Flutter Hooks**: Tối ưu hóa quản lý lifecycle và state trong widget

### Luồng dữ liệu với Riverpod
```dart
// Provider đơn giản
@riverpod
String message(ref) => 'Hello World';

// Provider với notifier
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() => const AuthState();
  
  Future<void> login(String email, String password) async {
    // Xử lý đăng nhập
  }
}

// Sử dụng trong UI
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final msg = ref.watch(messageProvider);
    final authState = ref.watch(authNotifierProvider);
    
    return Text(msg);
  }
}
```

### Điều hướng
- **Go Router**: Quản lý routing hiện đại với hỗ trợ Deep linking, URL parameters, và nested routes

```dart
// Cấu hình router
@Riverpod(keepAlive: true)
GoRouter router(ref) {
  return GoRouter(
    initialLocation: RoutePaths.login,
    routes: [
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.student,
        builder: (context, state) => const StudentHomePage(),
      ),
    ],
  );
}
```

### UI Components
- **Shadcn UI**: Bộ components UI hiện đại và tùy biến cao
- **Flutter ScreenUtil**: Hỗ trợ responsive UI trên nhiều thiết bị
- **Lottie Animations**: Animations phong phú và nhẹ
- **Infinite Scroll Pagination**: Tự động tải dữ liệu khi cuộn
- **Carousel Slider**: Hiển thị nội dung dạng carousel

### Network & API
- **Dio**: HTTP client mạnh mẽ với các tính năng nâng cao như interceptors, form data, cancel & retry requests
- **GraphQL Flutter**: Client GraphQL với hỗ trợ cache và subscription
- **Connectivity Plus**: Theo dõi trạng thái kết nối internet

```dart
// Cấu hình Dio client
@Riverpod(keepAlive: true)
Dio dio(ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
  
  // Thêm interceptors
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));
  
  return dio;
}
```

### Lưu trữ
- **Hive**: Database NoSQL nhẹ, nhanh và dễ sử dụng
- **Flutter Secure Storage**: Lưu trữ an toàn cho dữ liệu nhạy cảm
- **Path Provider**: Truy cập vào file system

```dart
// Cấu hình Hive Storage
@override
Future<void> init() async {
  try {
    await Hive.initFlutter();
    _registerAdapters();
    _logger.i('Hive storage initialized successfully');
  } catch (e, stackTrace) {
    _logger.e('Failed to initialize Hive storage', e, stackTrace);
    throw CacheException('Failed to initialize Hive storage: $e');
  }
}
```

### Đa ngôn ngữ
- **Easy Localization**: Hỗ trợ đa ngôn ngữ dễ dàng với JSON/YAML

```dart
// Cấu hình đa ngôn ngữ
await EasyLocalization.ensureInitialized();

runApp(
  EasyLocalization(
    supportedLocales: const [Locale('vi', 'VN'), Locale('en', 'US')],
    path: 'assets/translations',
    fallbackLocale: const Locale('vi', 'VN'),
    child: const MyApp(),
  ),
);
```

### Khác
- **Dartz**: Functional Programming với Either type để xử lý lỗi
- **Freezed**: Tạo immutable classes với pattern matching
- **Json Serializable**: Serialize/deserialize JSON tự động
- **Logger**: Logging với format đẹp và nhiều level

```dart
// Xử lý lỗi với Either
Future<Either<Failure, UserEntity>> login(LoginParams params) async {
  try {
    final result = await _remoteDataSource.login(params);
    return Right(result.toEntity());
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } on NetworkException {
    return Left(ConnectionFailure.noInternet());
  }
}
```

## 📱 Chức năng chi tiết

### Authentication
- **Đăng nhập và đăng ký**: Xác thực người dùng với email/password
- **Quản lý phiên làm việc**: Token-based authentication với refresh
- **Bảo mật**: CSRF protection, secure storage cho tokens

### Vai trò người dùng và chức năng

#### 🎓 Sinh viên
- **Quản lý sự kiện**: Xem danh sách, chi tiết và tài liệu sự kiện
- **Sự kiện**: Đăng ký tham gia các sự kiện, seminar

#### 🏢 Doanh nghiệp
- **Quản lý việc làm**: Đăng tin tuyển dụng, thực tập
- **Ứng viên**: Xem hồ sơ ứng viên và quản lý đơn ứng tuyển
- **Hồ sơ doanh nghiệp**: Cập nhật thông tin công ty
- **Phân tích**: Xem báo cáo về ứng viên và tương tác

### Luồng sự kiện

#### Đăng nhập
1. Người dùng nhập email và mật khẩu
2. Client gửi request đến API authentication
3. Server xác thực và trả về access token + refresh token
4. Client lưu token vào secure storage
5. Điều hướng người dùng đến trang chủ tương ứng với vai trò

#### Xem sự kiện (Sinh viên)
1. Load danh sách sự kiện từ API 
2. Hiển thị danh sách với pagination
3. Người dùng chọn sự kiện
4. Hiển thị chi tiết sự kiện với tabs: Thông tin, Thời gian, Địa điểm, Đối tượng, Đăng ký

#### Đăng tin tuyển dụng (Doanh nghiệp)
1. Doanh nghiệp điền form thông tin tuyển dụng
2. Validate thông tin form
3. Gửi request tạo tin tuyển dụng lên API
4. Hiển thị thông báo thành công

## ⚙️ Cài đặt và chạy

### Yêu cầu
- Flutter SDK: ^3.6.1
- Dart SDK: ^3.6.1
- Android Studio / VS Code với Flutter extensions
- Android SDK cho Android development
- Xcode cho iOS development (macOS)

### Cài đặt
```bash
# Clone repository
git clone https://github.com/your-username/mobile_app.git

# Di chuyển vào thư mục dự án
cd mobile_app

# Cài đặt dependencies
flutter pub get

# Tạo code generated
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📐 Quy ước phát triển

### Coding Style
- **Ngôn ngữ**: Sử dụng English cho mã nguồn và tài liệu
- **Kiểu dữ liệu**: Luôn khai báo kiểu dữ liệu cho biến và hàm
- **Đặt tên**:
  - `file_name.dart`: snake_case cho tên file
  - `ClassName`: PascalCase cho tên lớp
  - `variableName`: camelCase cho biến và hàm
  - `CONSTANT_NAME`: UPPER_SNAKE_CASE cho hằng số
- **Hàm**: Tạo hàm ngắn gọn, đơn chức năng, dưới 20 dòng
- **Comments**: Sử dụng /// cho documentation comments

```dart
/// Xác thực người dùng dựa trên thông tin đăng nhập
///
/// Trả về [UserEntity] nếu thành công hoặc [Failure] nếu thất bại
Future<Either<Failure, UserEntity>> authenticateUser({
  required String email,
  required String password,
}) async {
  // Implementation
}
```

### Nguyên tắc SOLID
- **Single Responsibility**: Mỗi class chỉ có một trách nhiệm duy nhất
- **Open/Closed**: Mở rộng không sửa đổi
- **Liskov Substitution**: Lớp con có thể thay thế lớp cha
- **Interface Segregation**: Interface nhỏ, chuyên biệt
- **Dependency Inversion**: Phụ thuộc vào abstraction, không phụ thuộc vào implementation

### Testing
- **Unit Tests**: Test cho business logic và use cases
- **Widget Tests**: Test cho UI components
- **Integration Tests**: Test cho flow hoàn chỉnh
- **Mục tiêu**: Test coverage > 80%

## 📋 Kế hoạch phát triển

### Phiên bản hiện tại
- Version: 1.0.0
- Status: Development

### Roadmap
- **v1.1.0**: Cải thiện UI/UX, thêm animations
- **v1.2.0**: Tích hợp thông báo real-time

## 📄 Giấy phép

[Điền thông tin giấy phép nếu có]

---

*Cập nhật lần cuối: [Ngày cập nhật]*
