import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:convert';

/// StorageService handles local data persistence
class StorageService {
  late SharedPreferences _prefs;
  static const String _userKey = 'user_data';
  static const String _tokenKey = 'auth_token';
  static const String _preferencesKey = 'user_preferences';

  /// Initialize the storage service
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save user data
  Future<bool> saveUserData(Map<String, dynamic> userData) async {
    try {
      final jsonString = jsonEncode(userData);
      return await _prefs.setString(_userKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }

  /// Get cached user data
  Map<String, dynamic>? getUserData() {
    try {
      final jsonString = _prefs.getString(_userKey);
      if (jsonString != null) {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }

  /// Save authentication token
  Future<bool> saveAuthToken(String token) async {
    try {
      return await _prefs.setString(_tokenKey, token);
    } catch (e) {
      throw Exception('Failed to save token: $e');
    }
  }

  /// Get authentication token
  String? getAuthToken() {
    try {
      return _prefs.getString(_tokenKey);
    } catch (e) {
      throw Exception('Failed to get token: $e');
    }
  }

  /// Clear all stored data
  Future<bool> clearAll() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      throw Exception('Failed to clear storage: $e');
    }
  }
}

/// Riverpod provider for StorageService
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});
