import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Route names/paths for easy navigation
class AppRoutes {
  static const String root = '/';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String reports = '/reports';
  static const String payroll = '/payroll';
  static const String analytics = '/analytics';
  static const String integration = '/integration';
  static const String support = '/support';
  static const String notFound = '/404';
}

/// GoRouter provider for app-wide routing
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    // Initial location when app launches
    initialLocation: AppRoutes.dashboard,
    // Handle errors and navigation failures
    errorPageBuilder: (context, state) => MaterialPage(
      child: NotFoundPage(error: state.error?.toString() ?? 'Unknown error'),
    ),
    // Define all application routes
    routes: [
      GoRoute(
        path: AppRoutes.root,
        redirect: (context, state) => AppRoutes.dashboard,
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        name: 'dashboard',
        builder: (context, state) => DashboardPage(),
        routes: [
          // Dashboard sub-routes if needed
        ],
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (context, state) => ProfilePage(),
        routes: [
          // Profile sub-routes if needed
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.reports,
        name: 'reports',
        builder: (context, state) => ReportsPage(),
      ),
      GoRoute(
        path: AppRoutes.payroll,
        name: 'payroll',
        builder: (context, state) => PayrollPage(),
      ),
      GoRoute(
        path: AppRoutes.analytics,
        name: 'analytics',
        builder: (context, state) => AnalyticsPage(),
      ),
      GoRoute(
        path: AppRoutes.integration,
        name: 'integration',
        builder: (context, state) => IntegrationPage(),
      ),
      GoRoute(
        path: AppRoutes.support,
        name: 'support',
        builder: (context, state) => SupportPage(),
      ),
      GoRoute(
        path: AppRoutes.notFound,
        builder: (context, state) => NotFoundPage(),
      ),
    ],
    // Redirect unmatched routes to 404
    redirect: (context, state) {
      // Add auth checks here if needed
      return null; // Allow navigation
    },
  );
});

// Placeholder imports - these will be created in screens/
// These are temporary placeholders for the routing to compile
// TODO: Replace with actual screen imports
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class PayrollPage extends StatelessWidget {
  const PayrollPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class IntegrationPage extends StatelessWidget {
  const IntegrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class NotFoundPage extends StatelessWidget {
  final String? error;
  const NotFoundPage({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('404 - Page Not Found'),
            if (error != null) Text(error!),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.dashboard),
              child: const Text('Return to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
