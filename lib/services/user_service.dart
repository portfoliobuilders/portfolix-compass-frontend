import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import '../models/user.dart';
import 'api_service.dart';

/// UserService handles user data operations
class UserService {
  final Dio _dio;
  final String _baseUrl = '/api/users';

  UserService(this._dio);

  /// Get current user profile
  Future<User> getCurrentUser(String userId) async {
    try {
      final response = await _dio.get('$_baseUrl/$userId');
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  /// Get user by ID
  Future<User> getUserById(String userId) async {
    try {
      final response = await _dio.get('$_baseUrl/$userId');
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  /// Update user profile
  Future<User> updateUserProfile(String userId, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/$userId',
        data: data,
      );
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}
