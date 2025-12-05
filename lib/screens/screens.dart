/// Flutter Screens for Portfolix Compass
/// This file exports all screen widgets

// Screens - Main Navigation
export 'dashboard_screen.dart';
export 'payroll_screen.dart';

/// SCREENS TO IMPLEMENT (Phase 3 Continuation):
///
/// 1. ✅ DashboardScreen - Main overview dashboard
///    - Overview metrics
///    - Key performance indicators
///    - Recent activity feed
///    - Quick action buttons
///
/// 2. ✅ PayrollScreen - Payroll management
///    - Payroll cycle management
///    - Payslips listing and download
///    - Processing history
///    - Tax compliance tracking
///
/// 3. ⏳ ReportsScreen - Report generation
///    - Available report templates
///    - Custom report builder
///    - Report history
///    - Export options (PDF, Excel)
///
/// 4. ⏳ AnalyticsScreen - Analytics and insights
///    - Trend analysis
///    - KPI charts and metrics
///    - Custom dashboards
///    - Data export capabilities
///
/// 5. ⏳ EmployeesScreen - Employee management
///    - Employee directory with search/filter
///    - Add/edit employee forms
///    - Bulk operations
///    - Import/export functionality
///
/// 6. ⏳ ProfileScreen - User profile management
///    - Personal information editing
///    - Password change
///    - Avatar upload
///    - Preferences and settings
///
/// 7. ⏳ SettingsScreen - Application settings
///    - Company settings
///    - User preferences
///    - Notification settings
///    - Integration management
///
/// 8. ⏳ IntegrationScreen - Third-party integrations
///    - Connected integrations list
///    - Add new integrations
///    - Sync status monitoring
///    - Webhook configuration
///
/// 9. ⏳ SupportScreen - Help and support
///    - FAQ section
///    - Contact support form
///    - Documentation links
///    - Version and system info
///
/// ARCHITECTURE PATTERN:
/// Each screen follows:
/// - ConsumerWidget for Riverpod integration
/// - Material Design 3 UI components
/// - Async state handling (loading, error, data)
/// - Responsive layouts
/// - Error boundaries
/// - Pull-to-refresh capability
///
/// NAVIGATION INTEGRATION:
/// Routes are defined in lib/config/routes.dart
/// with GoRouter for cross-platform navigation
///
/// STATE MANAGEMENT:
/// All screens use Riverpod providers from lib/providers/auth_provider.dart
/// for async data fetching and state management
