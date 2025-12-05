import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'api_service.dart';
import '../models/user.dart';

/// Authentication Service handles all authentication operations
class AuthService {
  final ApiService _apiService;
  final _secureStorage = const FlutterSecureStorage();
  
  // Auth state stream
  final _authStateController = StreamController<AuthState>.broadcast();
  Stream<AuthState> get authStateStream => _authStateController.stream;
  
  String? _currentToken;
  User? _currentUser;
  Timer? _tokenRefreshTimer;
  
  // Token storage keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'current_user';

  AuthService(this._apiService) {
    _initializeAuth();
  }

  /// Initialize authentication from stored data
  Future<void> _initializeAuth() async {
    try {
      final token = await getStoredAccessToken();
      if (token != null && !JwtDecoder.isExpired(token)) {
        _currentToken = token;
        _apiService.setAuthToken(token);
        _emitAuthState(AuthState.authenticated);
        _scheduleTokenRefresh();
      } else if (token != null) {
        await _refreshToken();
      } else {
        _emitAuthState(AuthState.unauthenticated);
      }
    } catch (e) {
      _emitAuthState(AuthState.error);
    }
  }

  /// Login user with email and password
  Future<User> login(String email, String password) async {
    try {
      _emitAuthState(AuthState.loading);
      final authResponse = await _apiService.login(email, password);
      
      await _setTokens(
        authResponse.accessToken,
        authResponse.refreshToken,
      );
      
      _currentToken = authResponse.accessToken;
      _apiService.setAuthToken(authResponse.accessToken);
      _scheduleTokenRefresh();
      
      _emitAuthState(AuthState.authenticated);
      return authResponse.user;
    } catch (e) {
      _emitAuthState(AuthState.error);
      rethrow;
    }
  }

  /// Register new user
  Future<User> register(String email, String password, String name) async {
    try {
      _emitAuthState(AuthState.loading);
      final authResponse = await _apiService.register(email, password, name);
      
      await _setTokens(
        authResponse.accessToken,
        authResponse.refreshToken,
      );
      
      _currentToken = authResponse.accessToken;
      _apiService.setAuthToken(authResponse.accessToken);
      _scheduleTokenRefresh();
      
      _emitAuthState(AuthState.authenticated);
      return authResponse.user;
    } catch (e) {
      _emitAuthState(AuthState.error);
      rethrow;
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      _tokenRefreshTimer?.cancel();
      await _apiService.logout();
      await _clearTokens();
      _currentToken = null;
      _currentUser = null;
      _apiService.clearAuthToken();
      _emitAuthState(AuthState.unauthenticated);
    } catch (e) {
      rethrow;
    }
  }

  /// Refresh access token
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await getStoredRefreshToken();
      if (refreshToken == null) {
        _emitAuthState(AuthState.unauthenticated);
        return false;
      }

      // Call refresh endpoint with refresh token
      // This assumes the API has a refresh endpoint
      // For now, we'll just validate the current token
      if (_currentToken != null && !JwtDecoder.isExpired(_currentToken!)) {
        return true;
      }

      _emitAuthState(AuthState.unauthenticated);
      return false;
    } catch (e) {
      _emitAuthState(AuthState.error);
      return false;
    }
  }

  /// Schedule token refresh before expiration
  void _scheduleTokenRefresh() {
    _tokenRefreshTimer?.cancel();
    
    if (_currentToken != null) {
      try {
        final decodedToken = JwtDecoder.decode(_currentToken!);
        final expiresIn = DateTime.fromMillisecondsSinceEpoch(
          decodedToken['exp'] * 1000,
        );
        
        // Refresh 1 minute before expiration
        final refreshTime = expiresIn.subtract(const Duration(minutes: 1));
        final timeUntilRefresh = refreshTime.difference(DateTime.now());
        
        if (timeUntilRefresh.isNegative) return;
        
        _tokenRefreshTimer = Timer(timeUntilRefresh, _refreshToken);
      } catch (e) {
        // Invalid token format
      }
    }
  }

  /// Store tokens in secure storage
  Future<void> _setTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  /// Clear stored tokens
  Future<void> _clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
    await _secureStorage.delete(key: _userKey);
  }

  /// Get stored access token
  Future<String?> getStoredAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  /// Get stored refresh token
  Future<String?> getStoredRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  /// Check if user is authenticated
  bool get isAuthenticated => _currentToken != null && _currentUser != null;

  /// Get current user
  User? get currentUser => _currentUser;

  /// Get current token
  String? get currentToken => _currentToken;

  /// Emit authentication state
  void _emitAuthState(AuthState state) {
    _authStateController.add(state);
  }

  /// Dispose resources
  void dispose() {
    _tokenRefreshTimer?.cancel();
    _authStateController.close();
  }
}

/// Authentication state enumeration
enum AuthState {
  loading,
  authenticated,
  unauthenticated,
  error,
}
