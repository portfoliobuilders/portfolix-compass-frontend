import 'package:riverpod/riverpod.dart';
import '../models/user.dart';
import '../services/services.dart';

/// Provider for user data fetching and caching
final userDataProvider = FutureProvider.family<User?, String>((ref, userId) async {
  final userService = ref.watch(userServiceProvider);
  try {
    return await userService.getUserById(userId);
  } catch (e) {
    return null;
  }
});

/// Provider for current user preferences
final userPreferencesProvider =
    FutureProvider.family<Map<String, dynamic>?, String>((ref, userId) async {
  final userService = ref.watch(userServiceProvider);
  try {
    return await userService.getUserPreferences(userId);
  } catch (e) {
    return null;
  }
});

/// Provider for user list
final userListProvider = FutureProvider<List<User>>((ref) async {
  // This will be implemented based on your API
  return [];
});

/// Cached user data with invalidation
final cachedUserProvider = StateNotifierProvider<
    CachedUserNotifier,
    Map<String, User>>((ref) {
  final userService = ref.watch(userServiceProvider);
  return CachedUserNotifier(userService);
});

/// State notifier for managing cached user data
class CachedUserNotifier extends StateNotifier<Map<String, User>> {
  final dynamic userService;

  CachedUserNotifier(this.userService) : super({});

  Future<User> fetchAndCache(String userId) async {
    if (state.containsKey(userId)) {
      return state[userId]!;
    }
    try {
      final user = await userService.getUserById(userId);
      state = {...state, userId: user};
      return user;
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  void invalidateUser(String userId) {
    final newState = Map<String, User>.from(state);
    newState.remove(userId);
    state = newState;
  }

  void clearCache() {
    state = {};
  }
}
