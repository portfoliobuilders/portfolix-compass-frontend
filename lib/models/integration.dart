import 'package:freezed_annotation/freezed_annotation.dart';

part 'integration.freezed.dart';
part 'integration.g.dart';

/// Integration model for third-party services
@freezed
class Integration with _$Integration {
  const factory Integration({
    required String id,
    required String name,
    required String provider,
    required String type,
    required String description,
    required IntegrationStatus status,
    required DateTime connectedAt,
    DateTime? lastSyncAt,
    required bool isActive,
    required Map<String, dynamic> config,
    required List<String> scopes,
    required bool requiresRefresh,
    String? accessToken,
    String? refreshToken,
    DateTime? tokenExpiresAt,
    @Default([]) List<String> webhookUrls,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Integration;

  factory Integration.fromJson(Map<String, dynamic> json) => _$IntegrationFromJson(json);
}

/// Integration status enumeration
@freezed
class IntegrationStatus with _$IntegrationStatus {
  const factory IntegrationStatus({
    required String status,
    required bool isConnected,
    required bool isHealthy,
    required DateTime lastCheckedAt,
    String? lastErrorMessage,
    required int errorCount,
    required int successCount,
    required double uptime,
    @Default('') String latestVersion,
    @Default('') String installedVersion,
  }) = _IntegrationStatus;

  factory IntegrationStatus.fromJson(Map<String, dynamic> json) => _$IntegrationStatusFromJson(json);
}

/// Integration log for tracking operations
@freezed
class IntegrationLog with _$IntegrationLog {
  const factory IntegrationLog({
    required String id,
    required String integrationId,
    required String action,
    required String status,
    required DateTime timestamp,
    required int durationMs,
    String? errorMessage,
    String? errorDetails,
    required int recordsProcessed,
    required Map<String, dynamic> metadata,
    @Default('') String requestId,
    @Default('') String responseCode,
  }) = _IntegrationLog;

  factory IntegrationLog.fromJson(Map<String, dynamic> json) => _$IntegrationLogFromJson(json);
}

/// Integration event for webhooks
@freezed
class IntegrationEvent with _$IntegrationEvent {
  const factory IntegrationEvent({
    required String id,
    required String integrationId,
    required String eventType,
    required DateTime timestamp,
    required Map<String, dynamic> payload,
    required bool isProcessed,
    DateTime? processedAt,
    int? retryCount,
    int? maxRetries,
    @Default('') String lastError,
  }) = _IntegrationEvent;

  factory IntegrationEvent.fromJson(Map<String, dynamic> json) => _$IntegrationEventFromJson(json);
}

/// Integration sync configuration
@freezed
class IntegrationSync with _$IntegrationSync {
  const factory IntegrationSync({
    required String id,
    required String integrationId,
    required String syncType,
    required String frequency,
    required bool isActive,
    required DateTime lastSyncAt,
    DateTime? nextScheduledSync,
    required bool syncInProgress,
    @Default(0) int progressPercentage,
    required List<String> syncedFields,
    String? lastError,
    @Default(0) int totalSyncCount,
    @Default(0) int failedSyncCount,
  }) = _IntegrationSync;

  factory IntegrationSync.fromJson(Map<String, dynamic> json) => _$IntegrationSyncFromJson(json);
}

/// Integration webhook configuration
@freezed
class WebhookConfig with _$WebhookConfig {
  const factory WebhookConfig({
    required String id,
    required String integrationId,
    required String url,
    required List<String> events,
    required bool isActive,
    required String secret,
    required int retryAttempts,
    required int retryDelaySeconds,
    required int timeoutSeconds,
    DateTime? createdAt,
    DateTime? lastTriggeredAt,
    @Default(0) int totalAttempts,
    @Default(0) int successCount,
    @Default(0) int failureCount,
  }) = _WebhookConfig;

  factory WebhookConfig.fromJson(Map<String, dynamic> json) => _$WebhookConfigFromJson(json);
}

/// Integration credential
@freezed
class IntegrationCredential with _$IntegrationCredential {
  const factory IntegrationCredential({
    required String id,
    required String integrationId,
    required String credentialType,
    @JsonKey(includeFromJson: false, includeToJson: false) required String secretValue,
    required DateTime expiresAt,
    required bool isActive,
    @Default([]) List<String> permissionScopes,
    DateTime? createdAt,
    DateTime? lastUsedAt,
    @Default(0) int usageCount,
  }) = _IntegrationCredential;

  factory IntegrationCredential.fromJson(Map<String, dynamic> json) => _$IntegrationCredentialFromJson(json);
}
