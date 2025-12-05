import 'package:freezed_annotation/freezed_annotation.dart';

part 'reports.freezed.dart';
part 'reports.g.dart';

/// Report model for generating and managing reports
@freezed
class Report with _$Report {
  const factory Report({
    required String id,
    required String name,
    required String type,
    required String description,
    required DateTime createdAt,
    required DateTime modifiedAt,
    required String createdBy,
    required String status,
    required String format,
    required int pageCount,
    required int fileSize,
    required String fileUrl,
    @Default([]) List<String> tags,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}

/// Report filter for filtering and searching reports
@freezed
class ReportFilter with _$ReportFilter {
  const factory ReportFilter({
    required String type,
    DateTime? startDate,
    DateTime? endDate,
    @Default([]) List<String> statuses,
    @Default([]) List<String> formats,
    String? createdBy,
    @Default('') String searchQuery,
    @Default(0) int page,
    @Default(10) int pageSize,
    @Default('createdAt') String sortBy,
    @Default('desc') String sortOrder,
  }) = _ReportFilter;

  factory ReportFilter.fromJson(Map<String, dynamic> json) => _$ReportFilterFromJson(json);
}

/// Export format for reports
@freezed
class ExportFormat with _$ExportFormat {
  const factory ExportFormat({
    required String format,
    required String mimeType,
    required String fileExtension,
    required bool supportsEncryption,
    required bool supportsDigitalSignature,
    @Default(0) int estimatedFileSize,
    @Default([]) List<String> supportedPaperSizes,
  }) = _ExportFormat;

  factory ExportFormat.fromJson(Map<String, dynamic> json) => _$ExportFormatFromJson(json);
}

/// Report template for standardized report generation
@freezed
class ReportTemplate with _$ReportTemplate {
  const factory ReportTemplate({
    required String id,
    required String name,
    required String category,
    required String description,
    required String layout,
    required List<String> availableMetrics,
    required List<String> availableFilters,
    required bool isCustomizable,
    required DateTime createdAt,
    required String createdBy,
    required int usageCount,
    @Default(true) bool isActive,
    @Default({}) Map<String, dynamic> defaultSettings,
  }) = _ReportTemplate;

  factory ReportTemplate.fromJson(Map<String, dynamic> json) => _$ReportTemplateFromJson(json);
}

/// Report generation configuration
@freezed
class ReportConfig with _$ReportConfig {
  const factory ReportConfig({
    required String templateId,
    required String name,
    required List<String> metrics,
    required Map<String, dynamic> filters,
    required String exportFormat,
    required bool includeCharts,
    required bool includeSummary,
    required bool includeDetails,
    @Default(false) bool scheduleRecurring,
    String? recurringPattern,
    @Default([]) List<String> recipientEmails,
    @Default({}) Map<String, dynamic> advancedSettings,
  }) = _ReportConfig;

  factory ReportConfig.fromJson(Map<String, dynamic> json) => _$ReportConfigFromJson(json);
}

/// Scheduled report execution
@freezed
class ScheduledReport with _$ScheduledReport {
  const factory ScheduledReport({
    required String id,
    required String reportId,
    required String schedule,
    required DateTime nextExecution,
    required DateTime? lastExecution,
    required bool isActive,
    required List<String> recipientEmails,
    required int executionCount,
    String? lastError,
  }) = _ScheduledReport;

  factory ScheduledReport.fromJson(Map<String, dynamic> json) => _$ScheduledReportFromJson(json);
}

/// Report generation status
@freezed
class ReportGenerationStatus with _$ReportGenerationStatus {
  const factory ReportGenerationStatus({
    required String reportId,
    required String status,
    required int progress,
    required DateTime startedAt,
    DateTime? completedAt,
    String? fileUrl,
    String? errorMessage,
    @Default(0) int totalPages,
    @Default(0) int processedRows,
  }) = _ReportGenerationStatus;

  factory ReportGenerationStatus.fromJson(Map<String, dynamic> json) => _$ReportGenerationStatusFromJson(json);
}
