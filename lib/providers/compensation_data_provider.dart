import 'package:riverpod/riverpod.dart';
import '../models/compensation.dart';
import '../services/services.dart';

/// Provider for compensation data fetching and caching
final compensationDataProvider =
    FutureProvider.family<Compensation?, String>((ref, compensationId) async {
  final apiService = ref.watch(apiServiceProvider);
  try {
    // Implement based on your API
    return null;
  } catch (e) {
    return null;
  }
});

/// Provider for user's compensation list
final userCompensationListProvider =
    FutureProvider.family<List<Compensation>, String>((ref, userId) async {
  final apiService = ref.watch(apiServiceProvider);
  try {
    // Implement based on your API
    return [];
  } catch (e) {
    return [];
  }
});

/// Provider for compensation analytics
final compensationAnalyticsProvider =
    FutureProvider.family<Map<String, dynamic>?, String>((ref, userId) async {
  final apiService = ref.watch(apiServiceProvider);
  try {
    // Implement based on your API
    return null;
  } catch (e) {
    return null;
  }
});

/// Cached compensation data with state management
final cachedCompensationProvider = StateNotifierProvider<
    CachedCompensationNotifier,
    Map<String, Compensation>>((ref) {
  return CachedCompensationNotifier();
});

/// State notifier for managing cached compensation data
class CachedCompensationNotifier extends StateNotifier<Map<String, Compensation>> {
  CachedCompensationNotifier() : super({});

  void addCompensation(String id, Compensation compensation) {
    state = {...state, id: compensation};
  }

  void removeCompensation(String id) {
    final newState = Map<String, Compensation>.from(state);
    newState.remove(id);
    state = newState;
  }

  void updateCompensation(String id, Compensation compensation) {
    state = {...state, id: compensation};
  }

  void clearCache() {
    state = {};
  }
}
