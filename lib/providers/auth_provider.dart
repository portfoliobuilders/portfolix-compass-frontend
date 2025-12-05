import 'package:riverpod/riverpod.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

/// Providers for API and Auth services
final apiServiceProvider = Provider((ref) => ApiService());

final authServiceProvider = Provider((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthService(apiService);
});

/// Auth state provider
final authStateProvider = StreamProvider((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateStream;
});

/// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.currentUser;
});

/// Is authenticated provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.isAuthenticated;
});

/// Login async provider
final loginProvider = FutureProvider.family<User, (String, String)>((ref, params) async {
  final authService = ref.watch(authServiceProvider);
  return authService.login(params.$1, params.$2);
});

/// Register async provider
final registerProvider = FutureProvider.family<User, (String, String, String)>((ref, params) async {
  final authService = ref.watch(authServiceProvider);
  return authService.register(params.$1, params.$2, params.$3);
});

/// Logout async provider
final logoutProvider = FutureProvider((ref) async {
  final authService = ref.watch(authServiceProvider);
  await authService.logout();
});

/// Get profile async provider
final getProfileProvider = FutureProvider((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getProfile();
});

/// Update profile async provider
final updateProfileProvider = FutureProvider.family<User, Map<String, dynamic>>((ref, data) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.updateProfile(data);
});

/// Change password async provider
final changePasswordProvider = FutureProvider.family<void, (String, String)>((ref, params) async {
  final apiService = ref.watch(apiServiceProvider);
  await apiService.changePassword(params.$1, params.$2);
});

/// Get employees provider
final getEmployeesProvider = FutureProvider.family<List<dynamic>, (int, int)>((ref, params) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getEmployees(page: params.$1, pageSize: params.$2);
});

/// Get employee provider
final getEmployeeProvider = FutureProvider.family<dynamic, String>((ref, id) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getEmployee(id);
});

/// Create employee provider
final createEmployeeProvider = FutureProvider.family<dynamic, Map<String, dynamic>>((ref, data) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.createEmployee(data);
});

/// Update employee provider
final updateEmployeeProvider = FutureProvider.family<dynamic, (String, Map<String, dynamic>)>((ref, params) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.updateEmployee(params.$1, params.$2);
});

/// Get payslips provider
final getPayslipsProvider = FutureProvider.family<List<dynamic>, (int, int)>((ref, params) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getPayslips(page: params.$1, pageSize: params.$2);
});

/// Get payslip provider
final getPayslipProvider = FutureProvider.family<dynamic, String>((ref, id) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getPayslip(id);
});

/// Process payroll provider
final processPayrollProvider = FutureProvider.family<dynamic, Map<String, dynamic>>((ref, data) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.processPayroll(data);
});

/// Get reports provider
final getReportsProvider = FutureProvider.family<List<dynamic>, (int, int)>((ref, params) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getReports(page: params.$1, pageSize: params.$2);
});

/// Generate report provider
final generateReportProvider = FutureProvider.family<dynamic, Map<String, dynamic>>((ref, config) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.generateReport(config);
});

/// Get analytics provider
final getAnalyticsProvider = FutureProvider.family<dynamic, String>((ref, category) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getAnalytics(category);
});

/// Get analytics summary provider
final getAnalyticsSummaryProvider = FutureProvider((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getAnalyticsSummary();
});

/// Get integrations provider
final getIntegrationsProvider = FutureProvider((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getIntegrations();
});

/// Connect integration provider
final connectIntegrationProvider = FutureProvider.family<dynamic, (String, Map<String, dynamic>)>((ref, params) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.connectIntegration(params.$1, params.$2);
});

/// Health check provider
final healthCheckProvider = FutureProvider((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.healthCheck();
});
