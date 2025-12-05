import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/routes.dart';
import 'config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase, local storage, and other services here
  runApp(
    const ProviderScope(
      child: PortfolixCompassApp(),
    ),
  );
}

class PortfolixCompassApp extends ConsumerWidget {
  const PortfolixCompassApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final themeData = AppTheme.lightTheme;

    return MaterialApp.router(
      title: 'Portfolix Compass',
      routerConfig: goRouter,
      theme: themeData,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Global error handling and app wrapper
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
