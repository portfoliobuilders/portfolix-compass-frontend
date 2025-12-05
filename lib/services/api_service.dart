import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/user.dart';
import '../models/employee.dart';
import '../models/payroll.dart';
import '../models/reports.dart';
import '../models/analytics.dart';
import '../models/integration.dart';

/// API Service handles all HTTP requests to the backend
class ApiService {
  late Dio _dio;
  String? _authToken;

  ApiService() {
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add request interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_authToken != null) {
            options.headers['Authorization'] = 'Bearer $_authToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          // Handle 401 Unauthorized errors
          if (error.response?.statusCode == 401) {
            // Token expired or invalid
            _authToken = null;
          }
          return handler.next(error);
        },
      ),
    );
  }

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  // Auth Endpoints
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiConfig.loginEndpoint,
        data: {
          'email': email,
          'password': password,
        },
      );
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> register(String email, String password, String name) async {
    try {
      final response = await _dio.post(
        ApiConfig.registerEndpoint,
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post(ApiConfig.logoutEndpoint);
      clearAuthToken();
    } catch (e) {
      rethrow;
    }
  }

  // User Endpoints
  Future<User> getProfile() async {
    try {
      final response = await _dio.get(ApiConfig.profileEndpoint);
      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        ApiConfig.profileEndpoint,
        data: data,
      );
      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      await _dio.post(
        ApiConfig.changePasswordEndpoint,
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // Employee Endpoints
  Future<List<Employee>> getEmployees({int page = 1, int pageSize = 10}) async {
    try {
      final response = await _dio.get(
        ApiConfig.employeesEndpoint,
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      final list = response.data['results'] as List;
      return list.map((e) => Employee.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Employee> getEmployee(String id) async {
    try {
      final response = await _dio.get('${ApiConfig.employeesEndpoint}/$id');
      return Employee.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Employee> createEmployee(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        ApiConfig.employeesEndpoint,
        data: data,
      );
      return Employee.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Employee> updateEmployee(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        '${ApiConfig.employeesEndpoint}/$id',
        data: data,
      );
      return Employee.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Payroll Endpoints
  Future<List<Payslip>> getPayslips({int page = 1, int pageSize = 10}) async {
    try {
      final response = await _dio.get(
        ApiConfig.payslipsEndpoint,
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      final list = response.data['results'] as List;
      return list.map((e) => Payslip.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Payslip> getPayslip(String id) async {
    try {
      final response = await _dio.get('${ApiConfig.payslipsEndpoint}/$id');
      return Payslip.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<PayrollRun> processPayroll(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        ApiConfig.payrollProcessEndpoint,
        data: data,
      );
      return PayrollRun.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Reports Endpoints
  Future<List<Report>> getReports({int page = 1, int pageSize = 10}) async {
    try {
      final response = await _dio.get(
        ApiConfig.reportsEndpoint,
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      final list = response.data['results'] as List;
      return list.map((e) => Report.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Report> generateReport(Map<String, dynamic> config) async {
    try {
      final response = await _dio.post(
        ApiConfig.generateReportEndpoint,
        data: config,
      );
      return Report.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Analytics Endpoints
  Future<Analytics> getAnalytics(String category) async {
    try {
      final response = await _dio.get(
        '${ApiConfig.analyticsEndpoint}/$category',
      );
      return Analytics.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<AnalyticsSummary> getAnalyticsSummary() async {
    try {
      final response = await _dio.get(ApiConfig.analyticsSummaryEndpoint);
      return AnalyticsSummary.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Integration Endpoints
  Future<List<Integration>> getIntegrations() async {
    try {
      final response = await _dio.get(ApiConfig.integrationsEndpoint);
      final list = response.data as List;
      return list.map((e) => Integration.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Integration> connectIntegration(String provider, Map<String, dynamic> config) async {
    try {
      final response = await _dio.post(
        '${ApiConfig.integrationsEndpoint}/connect',
        data: {
          'provider': provider,
          'config': config,
        },
      );
      return Integration.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Health Check
  Future<bool> healthCheck() async {
    try {
      final response = await _dio.get(ApiConfig.healthCheckEndpoint);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
