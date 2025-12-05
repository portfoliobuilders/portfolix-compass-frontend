# Portfolix Compass Flutter Architecture

## Overview
Portolix Compass is a production-grade Flutter application for enterprise compensation management. This document outlines the architecture, project structure, and best practices for development.

## Architecture Pattern: Clean Architecture + Riverpod

### Core Principles
- **Separation of Concerns**: Clear boundaries between layers
- **Testability**: Each component independently testable
- **Reusability**: DRY principle with shared utilities
- **Scalability**: Easy to add new features without affecting existing code
- **Type Safety**: Strict null-safety and strong typing

## Project Structure

```
lib/
├── config/              # Application configuration
│   ├── api_config.dart  # API endpoints and constants
│   ├── routes.dart      # GoRouter navigation setup
│   └── theme.dart       # Material Design 3 theming
│
├── models/              # Data models and entities
│   ├── user.dart
│   ├── employee.dart
│   ├── payroll.dart
│   └── ...
│
├── providers/           # Riverpod state management
│   ├── auth_provider.dart
│   ├── user_provider.dart
│   ├── dashboard_provider.dart
│   └── ...
│
├── services/            # Business logic and API
│   ├── api_service.dart         # HTTP client
│   ├── auth_service.dart        # Authentication
│   ├── user_service.dart        # User operations
│   └── ...
│
├── screens/             # Page/Screen widgets
│   ├── dashboard/
│   ├── profile/
│   ├── payroll/
│   ├── reports/
│   ├── analytics/
│   ├── settings/
│   ├── integration/
│   └── support/
│
├── widgets/             # Reusable custom widgets
│   ├── app_header.dart
│   ├── sidebar.dart
│   ├── error_boundary.dart
│   ├── salary_builder.dart
│   └── ...
│
├── utils/               # Utility functions
│   ├── validators.dart
│   ├── formatters.dart
│   ├── constants.dart
│   └── extensions.dart
│
└── main.dart            # Application entry point
```

## Technology Stack

### Core Framework
- **Flutter**: 3.13.0+
- **Dart**: 3.0.0+

### State Management
- **flutter_riverpod**: 2.4.0+ (Riverpod for state management)
- **riverpod_generator**: Code generation for providers

### Navigation
- **go_router**: 12.0.0+ (Declarative routing)

### HTTP/API
- **dio**: 5.3.0+ (HTTP client)
- **dio_logging**: Request/response logging

### Storage
- **shared_preferences**: User preferences
- **hive**: Local NoSQL database
- **hive_flutter**: Flutter integration

### UI/Design
- **Material Design 3**: Latest Material Design
- **flutter_svg**: SVG rendering
- **fl_chart**: Charts and graphs
- **table_calendar**: Calendar widget

### PDF & Reporting
- **pdf**: PDF generation
- **printing**: Print functionality

### Serialization
- **json_annotation**: JSON annotations
- **json_serializable**: Code generation for JSON
- **freezed**: Immutable model generation

### Utilities
- **logger**: Logging framework
- **intl**: Internationalization
- **uuid**: UUID generation
- **equatable**: Equality for Dart objects

## State Management with Riverpod

### Provider Types

1. **StateProvider**: Mutable state for simple values
```dart
final counterProvider = StateProvider((ref) => 0);
```

2. **StateNotifierProvider**: Complex state with methods
```dart
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
```

3. **FutureProvider**: Async operations (API calls)
```dart
final userProvider = FutureProvider<User?>((ref) async {
  final token = ref.watch(tokenProvider);
  return getUserFromAPI(token);
});
```

4. **StreamProvider**: Real-time data streams
```dart
final notificationsProvider = StreamProvider<List<Notification>>((ref) {
  return getNotificationsStream();
});
```

## API Integration Pattern

### Service Layer
```dart
class UserService {
  final Dio dio;
  
  Future<User> getUser(String userId) async {
    final response = await dio.get('/users/$userId');
    return User.fromJson(response.data);
  }
}
```

### Provider Integration
```dart
final userProvider = FutureProvider<User>((ref) async {
  final service = ref.watch(userServiceProvider);
  return service.getUser('userId');
});
```

## Navigation with GoRouter

### Routes Definition
```dart
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => DashboardPage(),
      ),
    ],
  );
});
```

### Navigation Usage
```dart
context.go('/dashboard');
context.pushNamed('profile');
context.pop();
```

## Error Handling

### API Errors
```dart
try {
  final user = await userService.getUser(id);
} catch (e) {
  // Handle API errors
  showErrorSnackbar(context, 'Failed to load user');
}
```

### Widget Error Boundary
```dart
ErrorBoundary(
  onError: (error, stack) {
    // Handle widget errors
  },
  child: SomeWidget(),
)
```

## Best Practices

### Code Organization
1. One widget per file (except small inline widgets)
2. Use descriptive naming conventions
3. Keep functions small and focused
4. Use const constructors where possible

### State Management
1. Use Riverpod providers for all state
2. Avoid setState in StatefulWidget
3. Keep business logic in services, not widgets
4. Use Freezed for immutable models

### Performance
1. Use const widgets to prevent rebuilds
2. Lazy load heavy widgets
3. Use ListView.builder for long lists
4. Cache API responses when appropriate

### Testing
1. Write unit tests for services
2. Write widget tests for UI components
3. Use mockito for mocking dependencies
4. Aim for 80%+ code coverage

## Multi-Platform Support

### Platform-Specific Code
```dart
import 'package:flutter/foundation.dart';

if (kIsWeb) {
  // Web-specific code
} else if (defaultTargetPlatform == TargetPlatform.iOS) {
  // iOS-specific code
} else if (defaultTargetPlatform == TargetPlatform.android) {
  // Android-specific code
}
```

## Development Workflow

### Environment Setup
1. Install Flutter SDK
2. Run `flutter pub get`
3. Run `flutter pub run build_runner build`
4. Run `flutter run`

### Code Generation
```bash
# Generate all code
flutter pub run build_runner build

# Watch mode for development
flutter pub run build_runner watch
```

### Code Quality
```bash
# Run analyzer
flutter analyze

# Format code
dart format lib

# Run tests
flutter test
```

## Security Considerations

1. **API Security**
   - Use HTTPS only
   - Implement token-based authentication
   - Validate SSL certificates
   - Refresh tokens when expired

2. **Data Storage**
   - Encrypt sensitive data in local storage
   - Use secure HTTP only for tokens
   - Clear sensitive data on logout

3. **Input Validation**
   - Validate all user inputs
   - Sanitize API responses
   - Implement rate limiting

## Deployment

### Build for Release
```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release

# Web
flutter build web --release
```

## Monitoring & Analytics

- **Firebase Analytics**: User behavior tracking
- **Logger**: Application logging
- **Error Reporting**: Crash reporting setup

## Future Enhancements

1. Offline support with Hive sync
2. Push notifications
3. Advanced analytics dashboard
4. In-app messaging
5. A/B testing framework
