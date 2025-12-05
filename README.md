# 🎯 Portfolix Compass Frontend - Flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.13.0-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0.0-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-Proprietary-red)](LICENSE)
[![Version](https://img.shields.io/badge/Version-2.0.0--flutter-green)](https://github.com/portfoliobuilders/portfolix-compass-frontend)

**Production-grade Flutter application** for Enterprise Compensation Management System. Cross-platform (iOS, Android, Web) with enterprise-level features including Salary Builder, Payroll Management, Offer Letters, Tax Compliance, and Multi-tenant Architecture.

🔗 **Backend Repository**: [portfolix-compass-backend](https://github.com/portfoliobuilders/portfolix-compass-backend)

---

## 📋 Table of Contents

- [Overview](#overview)
- [🎯 Migration Status](#migration-status)
- [✨ Features](#features)
- [🛠️ Tech Stack](#tech-stack)
- [🚀 Getting Started](#getting-started)
- [📁 Project Structure](#project-structure)
- [🏗️ Architecture](#architecture)
- [🧪 Testing](#testing)
- [📱 Multi-Platform Support](#multi-platform-support)
- [🔒 Security](#security)
- [📚 Documentation](#documentation)
- [🤝 Contributing](#contributing)
- [📄 License](#license)

---

## Overview

Portolix Compass is transitioning from React TypeScript to **Flutter**, a powerful cross-platform framework that enables development for iOS, Android, and Web from a single codebase. This migration provides:

✅ **Single Codebase**: One code repository for all platforms
✅ **Better Performance**: Native performance on all platforms
✅ **Consistent UI/UX**: Material Design 3 across all platforms  
✅ **Faster Development**: Hot reload for rapid iteration
✅ **Enterprise Ready**: Production-grade architecture and patterns

---

## 🎯 Migration Status

### Phase 1: Foundation ✅ COMPLETE
- [x] Project initialization and structure
- [x] Dependency management (pubspec.yaml)
- [x] Configuration setup (theme, routes, API config)
- [x] Architecture documentation
- [x] Main app entry point

### Phase 2: Core Services (IN PROGRESS)
- [x] Data models with Freezed
- [ ] Riverpod state management providers
- [ ] API service integration
- [ ] Authentication service
- [ ] User service

### Phase 3: Screens & Widgets (PENDING)
- [ ] All 9 application screens
- [ ] Custom widgets (Header, Sidebar, SalaryBuilder)
- [ ] Navigation implementation

### Phase 4: Advanced Features (PENDING)
- [ ] PDF generation and reporting
- [ ] Charts and analytics
- [ ] Offline support
- [ ] Push notifications

### Phase 5: Testing & Optimization (PENDING)
- [ ] Unit tests
- [ ] Widget tests
- [ ] Integration tests
- [ ] Performance optimization

### Phase 6: Deployment (PENDING)
- [ ] iOS build
- [ ] Android build
- [ ] Web deployment
- [ ] App Store submission

---

## ✨ Features

### Core Functionality
🔐 **Authentication & Authorization**
- Secure login/register with JWT tokens
- Role-based access control (Admin, Manager, Employee)
- Token refresh mechanism
- Session management

👥 **User Management**
- Complete user profiles
- Department and role assignment
- User activity tracking
- Profile image management

💼 **Payroll Management**
- Salary structure configuration
- Payroll processing and history
- Tax calculations
- Payment tracking

📊 **Analytics & Reporting**
- Real-time dashboards
- Employee statistics
- Payroll reports
- Custom report generation
- PDF export functionality

⚙️ **Settings & Configuration**
- Company settings management
- User preferences
- Integration management
- Support ticket system

### Advanced Features
- 📄 Offer letter generation
- 🧮 Advanced salary builder tool
- 📈 Interactive charts and graphs
- 🔄 Multi-tenant support
- 🔗 Third-party integrations
- 📱 Responsive design (all screen sizes)

---

## 🛠️ Tech Stack

### Core Framework
- **Flutter 3.13.0+** - Cross-platform UI framework
- **Dart 3.0.0+** - Programming language

### State Management
- **Riverpod 2.4.0** - Reactive provider system
- **flutter_riverpod** - Riverpod for Flutter
- **riverpod_generator** - Code generation

### Navigation & Routing
- **GoRouter 12.0.0** - Declarative routing system
- **URL-based navigation** - Deep linking support

### API & HTTP
- **Dio 5.3.0** - HTTP client
- **dio_logging** - HTTP logging
- **JSON Serializable** - JSON code generation

### Data & Storage
- **Freezed 2.4.0** - Immutable model generation
- **Hive 2.2.0** - Local NoSQL database
- **SharedPreferences** - Key-value storage

### UI & Design
- **Material Design 3** - Latest Material guidelines
- **flutter_svg** - SVG support
- **fl_chart** - Charts and graphs
- **table_calendar** - Calendar widget

### PDF & Reporting
- **pdf 3.10.0** - PDF generation
- **printing 5.11.0** - Print and share

### Utilities
- **logger** - Logging framework
- **intl** - Internationalization
- **uuid** - UUID generation
- **Firebase Analytics** - Analytics integration

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.13.0 or later
- Dart 3.0.0 or later
- Xcode 14.0+ (for iOS)
- Android Studio/NDK (for Android)
- Chrome/Edge (for Web)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/portfoliobuilders/portfolix-compass-frontend.git
cd portfolix-compass-frontend

# 2. Install dependencies
flutter pub get

# 3. Generate code (Freezed, JSON serialization, Riverpod)
flutter pub run build_runner build

# 4. Run the app
# Development (Android/iOS emulator or physical device)
flutter run

# Or for Web
flutter run -d chrome

# Production builds
flutter build apk --release      # Android
flutter build ios --release      # iOS  
flutter build web --release      # Web
```

### Environment Setup

1. **Create `.env` file** in project root:
```env
API_BASE_URL=http://localhost:5000/api
API_TIMEOUT=30
LOG_LEVEL=debug
```

2. **Update API Configuration** in `lib/config/api_config.dart`:
```dart
static const String baseUrl = 'http://localhost:5000/api';
static const String productionUrl = 'https://api.portfolixcompass.com/api';
```

---

## 📁 Project Structure

```
lib/
├── config/              # App configuration
│   ├── api_config.dart  # API endpoints
│   ├── routes.dart      # Navigation routes
│   └── theme.dart       # Material Design 3 theme
│
├── models/              # Data models (Freezed)
│   ├── user.dart        # User/Auth models
│   ├── employee.dart    # Employee models
│   └── ...
│
├── providers/           # Riverpod state management
│   ├── auth_provider.dart
│   ├── user_provider.dart
│   └── ...
│
├── services/            # Business logic & API
│   ├── api_service.dart
│   ├── auth_service.dart
│   └── ...
│
├── screens/             # Application pages
│   ├── dashboard/
│   ├── payroll/
│   ├── reports/
│   └── ...
│
├── widgets/             # Reusable widgets
│   ├── app_header.dart
│   ├── sidebar.dart
│   └── ...
│
├── utils/               # Utility functions
│   ├── validators.dart
│   ├── formatters.dart
│   └── constants.dart
│
└── main.dart           # App entry point
```

---

## 🏗️ Architecture

Portolix Compass follows **Clean Architecture** principles with **Riverpod** for state management:

### Layers
1. **Presentation Layer**: Widgets & UI (screens, widgets)
2. **State Management Layer**: Riverpod providers
3. **Business Logic Layer**: Services (API, Auth, User)
4. **Data Layer**: Models and repositories
5. **Configuration Layer**: Routes, theme, API config

### Data Flow
```
User Interaction → Widget → Provider → Service → API → Backend
             ↓
      Riverpod Watch
             ↓
        Widget Rebuild
```

For detailed architecture information, see [FLUTTER_ARCHITECTURE.md](FLUTTER_ARCHITECTURE.md)

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/services/api_service_test.dart

# Run tests in watch mode
flutter test --watch
```

### Testing Pyramid
- **Unit Tests**: Services, utilities, models (70%)
- **Widget Tests**: Custom widgets, screens (20%)
- **Integration Tests**: Full workflows (10%)

---

## 📱 Multi-Platform Support

### iOS
```bash
flutter build ios --release
# Output: build/ios/iphoneos/Runner.app
```

### Android  
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Web
```bash
flutter build web --release
# Output: build/web/
```

### Platform-Specific Code
Use conditional imports and platform checks:
```dart
import 'package:flutter/foundation.dart';

if (kIsWeb) {
  // Web-specific code
} else if (defaultTargetPlatform == TargetPlatform.iOS) {
  // iOS-specific code  
}
```

---

## 🔒 Security

✅ **Security Best Practices Implemented**
- HTTPS-only API communication
- JWT token-based authentication
- Secure token storage
- SSL certificate validation
- Input validation and sanitization
- XSS and CSRF protection
- Encrypted local storage for sensitive data

---

## 📚 Documentation

- **[FLUTTER_ARCHITECTURE.md](FLUTTER_ARCHITECTURE.md)** - Complete architecture guide
- **[DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md)** - Development setup and guidelines
- **[API Integration Guide](docs/API_INTEGRATION.md)** - Backend API integration
- **[State Management Guide](docs/STATE_MANAGEMENT.md)** - Riverpod usage patterns

---

## 🤝 Contributing

### Development Workflow
1. Create feature branch: `git checkout -b feature/your-feature`
2. Make changes and test: `flutter test`
3. Format code: `dart format lib`
4. Analyze: `flutter analyze`
5. Commit: `git commit -m "feat: description"`
6. Push and create pull request

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format` for formatting
- Ensure tests pass before submitting PR
- Write descriptive commit messages

---

## 📄 License

Copyright © 2025 Portfolio Builders. All rights reserved.
This project is proprietary and confidential.

---

## 🚀 Quick Links

- 🌐 [Official Website](https://portfolixcompass.com)
- 📧 [Contact Support](support@portfoliobuilders.com)
- 🐛 [Report Issues](https://github.com/portfoliobuilders/portfolix-compass-frontend/issues)
- 🎯 [Project Roadmap](ROADMAP.md)
- 📱 [Backend API Docs](https://api.portfolixcompass.com/docs)

---

**Last Updated**: December 2025  
**Status**: 🚧 Phase 2 - Core Services Implementation  
**Maintenance**: Active Development
