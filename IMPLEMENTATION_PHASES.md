# Flutter Portfolix Compass Frontend - Complete Implementation Phases

This document outlines the complete implementation roadmap for all 6 phases of the Flutter frontend development.

## Phase 2: Core Services (IN PROGRESS)

### 2.1 Data Models with Freezed ✅ PARTIAL

#### Completed:
- User authentication models
- Employee data models
- Payroll-related models

#### To Complete:

```dart
// lib/models/salary_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'salary_model.freezed.dart';
part 'salary_model.g.dart';

@freezed
class SalaryStructure with _$SalaryStructure {
  const factory SalaryStructure({
    required String id,
    required double baseSalary,
    required double hra,
    required double dearness,
    required double conveyance,
    required double medicalAllowance,
    required Map<String, double> deductions,
    required DateTime effectiveDate,
  }) = _SalaryStructure;

  factory SalaryStructure.fromJson(Map<String, dynamic> json) =>
      _$SalaryStructureFromJson(json);
}

@freezed
class PayslipData with _$PayslipData {
  const factory PayslipData({
    required String id,
    required String employeeId,
    required DateTime month,
    required double grossSalary,
    required double netSalary,
    required Map<String, double> earnings,
    required Map<String, double> deductions,
    required String status,
  }) = _PayslipData;

  factory PayslipData.fromJson(Map<String, dynamic> json) =>
      _$PayslipDataFromJson(json);
}

@freezed
class OfferLetterData with _$OfferLetterData {
  const factory OfferLetterData({
    required String id,
    required String candidateName,
    required String position,
    required String department,
    required double offerSalary,
    required DateTime joiningDate,
    required String reportingTo,
    required List<String> benefits,
  }) = _OfferLetterData;

  factory OfferLetterData.fromJson(Map<String, dynamic> json) =>
      _$OfferLetterDataFromJson(json);
}
```

### 2.2 Riverpod State Management Providers

```dart
// lib/providers/salary_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/salary_model.dart';
import '../services/api_service.dart';

final salaryServiceProvider = Provider((ref) => SalaryService());

final salaryStructureProvider = FutureProvider.family<SalaryStructure, String>(
  (ref, employeeId) async {
    final service = ref.watch(salaryServiceProvider);
    return service.getSalaryStructure(employeeId);
  },
);

final payslipsProvider = FutureProvider.family<List<PayslipData>, String>(
  (ref, employeeId) async {
    final service = ref.watch(salaryServiceProvider);
    return service.getPayslips(employeeId);
  },
);

final offerLettersProvider = FutureProvider<List<OfferLetterData>>((ref) async {
  final service = ref.watch(salaryServiceProvider);
  return service.getOfferLetters();
});

final selectedPayslipProvider = StateProvider<PayslipData?>((ref) => null);
```

### 2.3 API Service Integration

```dart
// lib/services/api_service.dart
import 'package:dio/dio.dart';
import '../models/salary_model.dart';

class SalaryService {
  final Dio _dio;
  
  SalaryService({Dio? dio}) : _dio = dio ?? Dio();

  Future<SalaryStructure> getSalaryStructure(String employeeId) async {
    try {
      final response = await _dio.get('/api/salary/structure/$employeeId');
      return SalaryStructure.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch salary structure: $e');
    }
  }

  Future<List<PayslipData>> getPayslips(String employeeId) async {
    try {
      final response = await _dio.get('/api/payroll/payslips/$employeeId');
      final list = response.data as List;
      return list.map((e) => PayslipData.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch payslips: $e');
    }
  }

  Future<List<OfferLetterData>> getOfferLetters() async {
    try {
      final response = await _dio.get('/api/offers/letters');
      final list = response.data as List;
      return list.map((e) => OfferLetterData.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch offer letters: $e');
    }
  }

  Future<PayslipData> generatePayslip(String employeeId, String month) async {
    try {
      final response = await _dio.post(
        '/api/payroll/generate',
        data: {'employeeId': employeeId, 'month': month},
      );
      return PayslipData.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to generate payslip: $e');
    }
  }
}
```

### 2.4 Authentication Service

```dart
// lib/services/auth_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';

class AuthService {
  final Dio _dio;
  final FlutterSecureStorage _storage;
  
  AuthService({Dio? dio, FlutterSecureStorage? storage})
      : _dio = dio ?? Dio(),
        _storage = storage ?? const FlutterSecureStorage();

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post('/api/auth/login', data: {
        'email': email,
        'password': password,
      });
      
      final user = UserModel.fromJson(response.data['user']);
      final token = response.data['token'];
      
      await _storage.write(key: 'auth_token', value: token);
      await _storage.write(key: 'user_id', value: user.id);
      
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'user_id');
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }
}
```

### 2.5 User Service

```dart
// lib/services/user_service.dart
import 'package:dio/dio.dart';
import '../models/user_model.dart';

class UserService {
  final Dio _dio;
  
  UserService({Dio? dio}) : _dio = dio ?? Dio();

  Future<UserModel> getUserProfile(String userId) async {
    try {
      final response = await _dio.get('/api/users/$userId');
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  Future<UserModel> updateProfile(String userId, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/users/$userId', data: data);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<List<UserModel>> getEmployees() async {
    try {
      final response = await _dio.get('/api/users/employees');
      final list = response.data as List;
      return list.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch employees: $e');
    }
  }
}
```

## Phase 3: Screens & Widgets (PENDING)

### 3.1 Dashboard Screen
```dart
// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome to Portfolix Compass',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  // Dashboard widgets here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 3.2 Payroll Screen
```dart
// lib/screens/payroll_screen.dart
// Comprehensive payroll management interface
```

### 3.3 Reports Screen
```dart
// lib/screens/reports_screen.dart
// Salary reports and analytics interface
```

### 3.4 Offer Letters Screen
```dart
// lib/screens/offer_letters_screen.dart
// Offer letter management interface
```

### 3.5 Employee Management Screen
```dart
// lib/screens/employees_screen.dart
// Employee CRUD operations
```

### 3.6-3.9 Additional Screens
- Settings Screen
- Attendance Screen
- Leave Management Screen
- Support Screen

### 3.10 Custom Widgets

```dart
// lib/widgets/app_header.dart
class AppHeader extends StatelessWidget {
  final String title;
  final VoidCallback onMenuTap;
  
  const AppHeader({required this.title, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.menu), onPressed: onMenuTap),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}
```

## Phase 4: Advanced Features (PENDING)

### 4.1 PDF Generation
```dart
// lib/services/pdf_service.dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFService {
  Future<void> generatePayslipPDF(PayslipData payslip) async {
    final pdf = pw.Document();
    // Add payslip content
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Text('Payslip'),
      ),
    );
  }
}
```

### 4.2 Charts & Analytics
```dart
// Using fl_chart package for visualizations
```

### 4.3 Offline Support
```dart
// lib/services/offline_service.dart
// Implement local caching with Hive
```

### 4.4 Push Notifications
```dart
// lib/services/notification_service.dart
// Firebase Cloud Messaging integration
```

## Phase 5: Testing & Optimization (PENDING)

### 5.1 Unit Tests
```dart
// test/services/auth_service_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthService', () {
    test('Login returns user on success', () async {
      // Test implementation
    });
  });
}
```

### 5.2 Widget Tests
```dart
// test/screens/dashboard_screen_test.dart
// Widget testing for all screens
```

### 5.3 Integration Tests
```dart
// integration_test/app_test.dart
// Full app workflow testing
```

## Phase 6: Deployment (PENDING)

### 6.1 iOS Build
```bash
flutter build ios --release
```

### 6.2 Android Build
```bash
flutter build apk --release
```

### 6.3 Web Deployment
```bash
flutter build web --release
```

### 6.4 App Store Submission
- iOS: App Store Connect submission
- Android: Google Play Console submission

---

**Last Updated**: December 6, 2025
**Status**: Phase 2-3 Implementation in Progress
