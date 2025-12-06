import 'package:riverpod/riverpod.dart';
import 'package:go_router/go_router.dart';

/// Navigation state
class NavigationState {
  final String currentRoute;
  final String? previousRoute;

  NavigationState({
    required this.currentRoute,
    this.previousRoute,
  });

  NavigationState copyWith({
    String? currentRoute,
    String? previousRoute,
  }) {
    return NavigationState(
      currentRoute: currentRoute ?? this.currentRoute,
      previousRoute: previousRoute ?? this.previousRoute,
    );
  }
}

/// Navigation notifier
class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier()
      : super(NavigationState(
          currentRoute: '/',
          previousRoute: null,
        ));

  void navigate(String route) {
    state = NavigationState(
      currentRoute: route,
      previousRoute: state.currentRoute,
    );
  }

  void goBack() {
    if (state.previousRoute != null) {
      state = NavigationState(
        currentRoute: state.previousRoute!,
        previousRoute: null,
      );
    }
  }
}

/// Riverpod provider for navigation state
final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});

/// Routes for the application
class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String compensation = '/compensation';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String analytics = '/analytics';
  static const String compareCompensation = '/compare';
}

/// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) {
          // Home screen widget
          return SizedBox.expand(child: Container());
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) {
          // Login screen widget
          return SizedBox.expand(child: Container());
        },
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        name: 'dashboard',
        builder: (context, state) {
          // Dashboard screen widget
          return SizedBox.expand(child: Container());
        },
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (context, state) {
          // Profile screen widget
          return SizedBox.expand(child: Container());
        },
      ),
      GoRoute(
        path: AppRoutes.compensation,
        name: 'compensation',
        builder: (context, state) {
          // Compensation screen widget
          return SizedBox.expand(child: Container());
        },
      ),
    ],
  );
});
