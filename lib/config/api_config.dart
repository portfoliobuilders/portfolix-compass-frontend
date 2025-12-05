/// API Configuration for Portfolix Compass Backend
/// Defines all backend endpoints, timeout values, and HTTP configurations

class ApiConfig {
  // Backend Base URL Configuration
  // Update these values based on environment
  static const String baseUrl = 'http://localhost:5000/api';
  static const String productionUrl = 'https://api.portfolixcompass.com/api';
  static const String stagingUrl = 'https://staging-api.portfolixcompass.com/api';
  static const String developmentUrl = 'http://localhost:5000/api';

  // API Version
  static const String apiVersion = 'v1';

  // Timeout Configuration (in seconds)
  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;
  static const int sendTimeout = 30;

  // HTTP Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Client-Version': '1.0.0',
    'X-Client-Platform': 'flutter',
  };

  // Authentication
  static const String authHeaderName = 'Authorization';
  static const String tokenPrefix = 'Bearer';

  // API Endpoints - Authentication
  static const String loginEndpoint = '/auth/login';
  static const String logoutEndpoint = '/auth/logout';
  static const String registerEndpoint = '/auth/register';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String verifyTokenEndpoint = '/auth/verify';

  // API Endpoints - Users
  static const String usersEndpoint = '/users';
  static const String userProfileEndpoint = '/users/profile';
  static const String updateProfileEndpoint = '/users/profile';
  static const String changePasswordEndpoint = '/users/change-password';

  // API Endpoints - Dashboard
  static const String dashboardEndpoint = '/dashboard';
  static const String dashboardStatsEndpoint = '/dashboard/stats';
  static const String dashboardChartsEndpoint = '/dashboard/charts';

  // API Endpoints - Employees
  static const String employeesEndpoint = '/employees';
  static const String employeeDetailsEndpoint = '/employees/:id';
  static const String createEmployeeEndpoint = '/employees';
  static const String updateEmployeeEndpoint = '/employees/:id';
  static const String deleteEmployeeEndpoint = '/employees/:id';

  // API Endpoints - Payroll
  static const String payrollEndpoint = '/payroll';
  static const String payrollRunEndpoint = '/payroll/run';
  static const String payrollHistoryEndpoint = '/payroll/history';
  static const String salaryStructureEndpoint = '/payroll/salary-structure';

  // API Endpoints - Reports
  static const String reportsEndpoint = '/reports';
  static const String reportTypesEndpoint = '/reports/types';
  static const String generateReportEndpoint = '/reports/generate';
  static const String exportReportEndpoint = '/reports/export';

  // API Endpoints - Analytics
  static const String analyticsEndpoint = '/analytics';
  static const String analyticsMetricsEndpoint = '/analytics/metrics';
  static const String analyticsChartsEndpoint = '/analytics/charts';

  // API Endpoints - Settings
  static const String settingsEndpoint = '/settings';
  static const String companySettingsEndpoint = '/settings/company';
  static const String userSettingsEndpoint = '/settings/user';

  // API Endpoints - Integrations
  static const String integrationsEndpoint = '/integrations';
  static const String integrationStatusEndpoint = '/integrations/status';

  // API Endpoints - Support
  static const String supportEndpoint = '/support';
  static const String ticketsEndpoint = '/support/tickets';
  static const String createTicketEndpoint = '/support/tickets';

  /// Get the appropriate base URL based on environment
  static String getBaseUrl({String environment = 'development'}) {
    switch (environment) {
      case 'production':
        return productionUrl;
      case 'staging':
        return stagingUrl;
      case 'development':
      default:
        return developmentUrl;
    }
  }

  /// Build full endpoint URL
  static String buildEndpoint(String endpoint) {
    return '$baseUrl/$apiVersion$endpoint';
  }

  /// Build full endpoint with path parameters
  static String buildEndpointWithParams(
    String endpoint, {
    Map<String, String>? params,
  }) {
    String finalEndpoint = endpoint;
    if (params != null) {
      params.forEach((key, value) {
        finalEndpoint = finalEndpoint.replaceAll(':$key', value);
      });
    }
    return buildEndpoint(finalEndpoint);
  }

  /// Build query string from parameters
  static String buildQueryString(Map<String, dynamic>? params) {
    if (params == null || params.isEmpty) return '';

    final queryParams = <String>[];
    params.forEach((key, value) {
      if (value != null) {
        queryParams.add('$key=$value');
      }
    });

    return queryParams.isNotEmpty ? '?${queryParams.join('&')}' : '';
  }

  /// Check if URL is absolute
  static bool isAbsoluteUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }
}
