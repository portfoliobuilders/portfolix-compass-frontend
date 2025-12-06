import 'package:riverpod/riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state_provider.freezed.dart';

/// Global app state
@freezed
class AppState with _$AppState {
  const factory AppState({
    required bool isLoading,
    required bool isDarkMode,
    required String? errorMessage,
    required String? successMessage,
  }) = _AppState;
}

/// App state notifier
class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier()
      : super(const AppState(
          isLoading: false,
          isDarkMode: false,
          errorMessage: null,
          successMessage: null,
        ));

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setDarkMode(bool isDarkMode) {
    state = state.copyWith(isDarkMode: isDarkMode);
  }

  void setError(String? error) {
    state = state.copyWith(errorMessage: error);
  }

  void setSuccess(String? success) {
    state = state.copyWith(successMessage: success);
  }

  void clearMessages() {
    state = state.copyWith(errorMessage: null, successMessage: null);
  }
}

/// Riverpod provider for app state
final appStateProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
