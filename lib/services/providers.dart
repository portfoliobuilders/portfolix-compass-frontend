import 'package:riverpod/riverpod.dart';
import 'api_service.dart';
import 'auth_service.dart';
import 'storage_service.dart';
import 'user_service.dart';
import 'notification_service.dart';

/// Central registry of all Riverpod providers for the application
/// This file imports and re-exports all service providers

// API Service Providers
export 'api_service.dart';

// Auth Service Providers
export 'auth_service.dart';

// Storage Service Providers
export 'storage_service.dart';

// User Service Providers
export 'user_service.dart';

// Notification Service Providers
export 'notification_service.dart';

/// Combined provider setup
final serviceProvidersSetup = FutureProvider<void>((ref) async {
  // Initialize all services
  final storage = ref.watch(storageServiceProvider);
  await storage.init();

  // Initialize notifications
  await NotificationService.init();
});
