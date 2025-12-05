import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User model representing an authenticated user in Portfolix Compass
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    String? profileImage,
    required String role,
    required String companyId,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? phone,
    String? department,
    DateTime? lastLogin,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  const User._();

  String get fullName => '$firstName $lastName';
  bool get isAdmin => role == 'admin';
  bool get isManager => role == 'manager';
  bool get isEmployee => role == 'employee';
}

/// User authentication response from backend
@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    required String refreshToken,
    required User user,
    required int expiresIn,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

/// Login request payload
@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

/// Register request payload
@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String companyId,
    String? phone,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}
