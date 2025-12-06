# Phase 2: Core Services Implementation Checklist

## Quick Reference Guide for Flutter Frontend Development

### Implementation Priority: HIGH
**Target Completion**: Week 1-2 of Development
**Team**: Flutter Development Team (2-3 developers)
**Status**: 🔄 IN PROGRESS

---

## Phase 2.1: Data Models with Freezed ✅ 40% COMPLETE

### Models to Create:

#### Authentication Models
- [x] UserModel (User authentication and profile)
- [x] AuthTokenModel (JWT token management)
- [x] CredentialsModel (Login/register credentials)
- [ ] RefreshTokenModel (Token refresh mechanism)

#### Payroll Models  
- [ ] SalaryStructureModel (Salary components)
  - Basic salary
  - HRA, Dearness, Conveyance
  - Medical/Other allowances
  - Deductions mapping
- [ ] PayslipModel (Individual payslip data)
  - Gross/Net salary
  - Earnings breakdown
  - Deductions breakdown
  - Tax calculations
- [ ] OfferLetterModel (Job offer data)
  - Candidate details
  - Position & salary
  - Joining date
  - Benefits list

#### Employee Models
- [ ] EmployeeProfileModel (Employee information)
- [ ] EmployeeDepartmentModel (Department assignment)
- [ ] EmployeeAttendanceModel (Attendance tracking)

### File Locations:
```
lib/models/
├── salary_model.dart
├── payslip_model.dart
├── offer_letter_model.dart
├── employee_model.dart
└── auth_model.dart
```

### Generation Commands:
```bash
# After creating models, run:
flutter pub run build_runner build

# Watch mode for development:
flutter pub run build_runner watch
```

---

## Phase 2.2: Riverpod State Management Providers ⏳ 20% COMPLETE

### Providers to Create:

#### Authentication Providers
- [ ] authServiceProvider (Auth service instance)
- [ ] authStateProvider (Current auth state)
- [ ] userProvider (Current user data)
- [ ] isAuthenticatedProvider (Auth status)
- [ ] authTokenProvider (JWT token)

#### Payroll Providers
- [ ] salaryServiceProvider (Salary service instance)
- [ ] salaryStructureProvider (Current salary structure)
- [ ] payslipsProvider (List of payslips)
- [ ] offerLettersProvider (List of offer letters)
- [ ] selectedPayslipProvider (Selected payslip state)

#### Employee Providers
- [ ] employeeServiceProvider (Employee service instance)
- [ ] employeeListProvider (List of employees)
- [ ] employeeProfileProvider (Selected employee profile)
- [ ] departmentListProvider (List of departments)

### File Locations:
```
lib/providers/
├── auth_provider.dart
├── salary_provider.dart
├── payroll_provider.dart
├── employee_provider.dart
└── shared_providers.dart
```

### Testing:
```bash
# Run provider tests
flutter test test/providers/
```

---

## Phase 2.3: API Service Integration ⏳ 15% COMPLETE

### Services to Create:

#### APIService (Core HTTP Client)
- [ ] Setup Dio with interceptors
- [ ] Configure base URL and timeout
- [ ] Implement error handling
- [ ] Setup request/response logging
- [ ] Configure SSL pinning for production

#### SalaryService
- [ ] getSalaryStructure(employeeId)
- [ ] getPayslips(employeeId, filters)
- [ ] getOfferLetters()
- [ ] generatePayslip(employeeId, month)
- [ ] exportPayslipPDF(payslipId)

#### AuthService
- [ ] login(email, password)
- [ ] logout()
- [ ] register(userData)
- [ ] refreshToken()
- [ ] validateToken()
- [ ] getToken()
- [ ] storeToken(token)

#### UserService
- [ ] getUserProfile(userId)
- [ ] updateProfile(userId, data)
- [ ] getEmployees(filters)
- [ ] searchEmployees(query)
- [ ] uploadProfileImage(file)

### File Locations:
```
lib/services/
├── api_service.dart
├── salary_service.dart
├── auth_service.dart
├── user_service.dart
└── http_interceptor.dart
```

### Configuration:
```dart
// lib/config/api_config.dart
class ApiConfig {
  static const String baseUrlDev = 'http://localhost:5000/api';
  static const String baseUrlProd = 'https://api.portfolixcompass.com/api';
  static const Duration timeout = Duration(seconds: 30);
}
```

---

## Phase 2.4: Authentication Service 🔄 30% COMPLETE

### Features to Implement:

#### Login & Registration
- [ ] Email/password login
- [ ] User registration with validation
- [ ] Email verification
- [ ] Password reset flow
- [ ] Social login (Optional)

#### Token Management
- [ ] Store JWT securely (flutter_secure_storage)
- [ ] Auto-refresh token before expiry
- [ ] Handle token expiration
- [ ] Clear tokens on logout

#### Session Management
- [ ] Maintain session state
- [ ] Handle concurrent requests
- [ ] Session timeout handling
- [ ] Multi-device session control

### Dependencies:
```yaml
dependencies:
  flutter_secure_storage: ^9.0.0
  jwt_decoder: ^2.0.1
  dio: ^5.3.0
```

### Security Checklist:
- [ ] Use HTTPS only
- [ ] Store tokens in secure storage
- [ ] Implement CSRF token handling
- [ ] Validate SSL certificates
- [ ] Implement certificate pinning
- [ ] Add timeout for inactive sessions

---

## Phase 2.5: User Service ⏳ 10% COMPLETE

### Features to Implement:

#### User Profile Management
- [ ] Fetch user profile
- [ ] Update profile information
- [ ] Change password
- [ ] Update profile picture
- [ ] Manage notifications preferences

#### Employee Management
- [ ] Fetch employees list
- [ ] Search employees
- [ ] Filter by department/designation
- [ ] Get employee details
- [ ] Export employee data

#### Department Management
- [ ] Fetch departments list
- [ ] Get department details
- [ ] Filter employees by department

### Caching Strategy:
```dart
// Implement local caching with Hive
// Cache user profile for 1 hour
// Cache employee list for 30 minutes
// Cache department list for 2 hours
```

---

## Development Workflow

### Step-by-Step Implementation:

1. **Create Models** (Day 1-2)
   ```bash
   flutter pub run build_runner build
   ```

2. **Setup Services** (Day 2-3)
   - Configure API client
   - Implement error handling
   - Setup interceptors

3. **Create Providers** (Day 3-4)
   - Setup Riverpod providers
   - Link services to providers
   - Implement caching

4. **Testing** (Day 4-5)
   - Unit test services
   - Test providers
   - Integration tests

5. **Integration** (Day 5)
   - Connect to UI screens
   - Test end-to-end
   - Performance optimization

### Testing Commands:
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/services/auth_service_test.dart
```

---

## Code Quality Checklist

### Before Committing Code:
- [ ] Run `flutter analyze`
- [ ] Format code with `dart format lib/`
- [ ] Write tests (80%+ coverage target)
- [ ] Document public APIs with comments
- [ ] Review for security issues
- [ ] Check for null safety
- [ ] Verify error handling
- [ ] Test edge cases

### Commit Message Format:
```
feat(phase2): Implement salary model with Freezed

- Add SalaryStructure model
- Add PayslipData model
- Add proper JSON serialization
- Add unit tests
```

---

## Dependencies Required

```yaml
# Core
flutter_riverpod: ^2.4.0
riverpod_generator: ^2.3.0
freezes: ^2.4.0
json_serializable: ^6.7.0

# API & HTTP
dio: ^5.3.0
dio_logging: ^0.0.0

# Storage
flutter_secure_storage: ^9.0.0
hive: ^2.2.0

# Utilities
jwt_decoder: ^2.0.1
logger: ^2.0.0
```

Run: `flutter pub get`

---

## Timeline & Milestones

| Task | Timeline | Assignee | Status |
|------|----------|----------|--------|
| Phase 2.1 Models | Day 1-2 | Dev 1 | 40% |
| Phase 2.2 Providers | Day 2-3 | Dev 2 | 20% |
| Phase 2.3 API Service | Day 3-4 | Dev 1 | 15% |
| Phase 2.4 Auth Service | Day 4-5 | Dev 3 | 30% |
| Phase 2.5 User Service | Day 5 | Dev 2 | 10% |
| Testing & Integration | Day 6 | All | 0% |

---

## Deployment Checklist

- [ ] All tests passing (100%)
- [ ] No analyzer warnings
- [ ] Security audit completed
- [ ] Performance profiling done
- [ ] API documentation reviewed
- [ ] Error handling complete
- [ ] Logging implemented
- [ ] Versioning updated
- [ ] CHANGELOG updated
- [ ] PR review completed
- [ ] Merged to main branch

---

## Resources & References

- [Freezed Documentation](https://pub.dev/packages/freezed)
- [Riverpod Documentation](https://riverpod.dev)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
- [IMPLEMENTATION_PHASES.md](./IMPLEMENTATION_PHASES.md) - Full code templates

---

**Last Updated**: December 6, 2025
**Phase Status**: 🔄 IN PROGRESS
**Overall Progress**: 23% Complete
