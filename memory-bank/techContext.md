# Technical Context

## Development Environment

### Required Tools
- Flutter SDK (>=3.6.1)
- Dart SDK (>=3.6.1)
- Android Studio / VS Code
- Git
- Android SDK
- Xcode (for iOS development)

### IDE Setup
1. VS Code Extensions:
   - Dart
   - Flutter
   - Riverpod
   - Error Lens
   - GitLens
   - Pubspec Assist

2. Android Studio Plugins:
   - Flutter
   - Dart
   - Flutter Riverpod Snippets

## Project Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  riverpod_annotation: ^2.6.1
  hooks_riverpod: ^2.6.1
  flutter_hooks: ^0.20.5
  go_router: ^14.3.0
  shadcn_ui: ^0.24.0
  dio: ^5.8.0+1
  hive: ^2.2.3
  flutter_secure_storage: ^9.2.4
```

### Development Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.15
  freezed: ^2.4.5
  json_serializable: ^6.7.1
  riverpod_generator: ^2.6.3
  custom_lint: ^0.7.0
  riverpod_lint: ^2.6.3
```

## Code Generation

### Required Commands
```bash
# Generate Freezed models
flutter pub run build_runner build --delete-conflicting-outputs

# Generate Riverpod providers
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for development
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Project Structure

### Directory Organization
```
lib/
├── core/                  # Core functionality
├── features/              # Feature modules
├── main.dart              # Application entry point
└── generated/             # Generated code
```

### Feature Module Structure
```
feature/
├── data/                  # Data layer
├── domain/                # Domain layer
└── presentation/          # Presentation layer
```

## Development Workflow

### Git Workflow
1. Feature branches from `develop`
2. Pull requests to `develop`
3. Regular merges to `main`
4. Semantic versioning

### Code Style
- Follow Dart style guide
- Use trailing commas
- Maximum line length: 80 characters
- Use `const` where possible
- Prefer composition over inheritance

## Build and Deployment

### Android
1. Update version in `pubspec.yaml`
2. Update version in `android/app/build.gradle`
3. Generate signed APK/Bundle
4. Upload to Play Store

### iOS
1. Update version in `pubspec.yaml`
2. Update version in `ios/Runner/Info.plist`
3. Archive in Xcode
4. Upload to App Store

## Testing

### Unit Tests
- Test files next to implementation
- Use `test` package
- Mock dependencies with `mocktail`

### Widget Tests
- Test UI components
- Use `flutter_test` package
- Mock providers with `ProviderScope`

### Integration Tests
- Test complete features
- Use `integration_test` package
- Run on physical devices

## Performance Monitoring

### Metrics to Track
1. App Launch Time
2. Frame Rendering
3. Memory Usage
4. Network Requests
5. Storage Operations

### Tools
- Flutter DevTools
- Firebase Performance Monitoring
- Custom logging

## Security

### Key Security Measures
1. Secure Storage
   - Use `flutter_secure_storage`
   - Encrypt sensitive data
   - Secure token management

2. Network Security
   - HTTPS only
   - CSRF protection
   - Input validation

3. Data Protection
   - Encrypted local storage
   - Secure file handling
   - Proper session management 