import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics.freezed.dart';
part 'analytics.g.dart';

/// Analytics data model for tracking metrics and insights
@freezed
class Analytics with _$Analytics {
  const factory Analytics({
    required String id,
    required String title,
    required String category,
    required DateTime startDate,
    required DateTime endDate,
    required Map<String, dynamic> metrics,
    required List<Trend> trends,
    required List<MetricData> metricDataPoints,
    required String frequency,
    @Default(true) bool isActive,
    DateTime? lastUpdated,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Analytics;

  factory Analytics.fromJson(Map<String, dynamic> json) => _$AnalyticsFromJson(json);
}

/// Trend model for tracking trend data
@freezed
class Trend with _$Trend {
  const factory Trend({
    required String id,
    required String name,
    required String type,
    required double value,
    required double previousValue,
    required double percentageChange,
    required String direction,
    required DateTime date,
    required String unit,
    @Default({}) Map<String, dynamic> attributes,
  }) = _Trend;

  factory Trend.fromJson(Map<String, dynamic> json) => _$TrendFromJson(json);
}

/// Metric data point for detailed analytics
@freezed
class MetricData with _$MetricData {
  const factory MetricData({
    required String id,
    required String metricName,
    required double value,
    required DateTime timestamp,
    required String unit,
    required String dimension,
    required String dimensionValue,
    @Default(0.0) double percentOfTotal,
    @Default(0.0) double benchmarkValue,
    @Default('') String status,
  }) = _MetricData;

  factory MetricData.fromJson(Map<String, dynamic> json) => _$MetricDataFromJson(json);
}

/// Analytics filter for querying analytics data
@freezed
class AnalyticsFilter with _$AnalyticsFilter {
  const factory AnalyticsFilter({
    required DateTime startDate,
    required DateTime endDate,
    @Default([]) List<String> categories,
    @Default([]) List<String> metrics,
    @Default([]) List<String> dimensions,
    @Default('daily') String granularity,
    @Default('') String searchQuery,
    @Default([]) List<String> comparisonPeriods,
    @Default(0) int pageNumber,
    @Default(50) int pageSize,
  }) = _AnalyticsFilter;

  factory AnalyticsFilter.fromJson(Map<String, dynamic> json) => _$AnalyticsFilterFromJson(json);
}

/// Analytics summary providing aggregated data
@freezed
class AnalyticsSummary with _$AnalyticsSummary {
  const factory AnalyticsSummary({
    required DateTime periodStart,
    required DateTime periodEnd,
    required int totalRecords,
    required int uniqueUsers,
    required double totalRevenue,
    required double averageValue,
    required Map<String, int> categoryBreakdown,
    required List<Trend> topTrends,
    required List<String> anomalies,
    @Default({}) Map<String, dynamic> customMetrics,
  }) = _AnalyticsSummary;

  factory AnalyticsSummary.fromJson(Map<String, dynamic> json) => _$AnalyticsSummaryFromJson(json);
}

/// Forecast model for predictive analytics
@freezed
class Forecast with _$Forecast {
  const factory Forecast({
    required String id,
    required String metricName,
    required List<DateTime> forecastDates,
    required List<double> forecastValues,
    required List<double> confidenceIntervalLow,
    required List<double> confidenceIntervalHigh,
    required double accuracy,
    required String model,
    required DateTime createdAt,
    @Default(false) bool isOutOfDate,
  }) = _Forecast;

  factory Forecast.fromJson(Map<String, dynamic> json) => _$ForecastFromJson(json);
}

/// Anomaly detection model
@freezed
class AnomalyDetection with _$AnomalyDetection {
  const factory AnomalyDetection({
    required String id,
    required String metricName,
    required double detectedValue,
    required double expectedValue,
    required double deviation,
    required String severity,
    required DateTime detectedAt,
    required String description,
    @Default(false) bool isResolved,
    String? resolution,
  }) = _AnomalyDetection;

  factory AnomalyDetection.fromJson(Map<String, dynamic> json) => _$AnomalyDetectionFromJson(json);
}

/// Custom metric configuration
@freezed
class CustomMetric with _$CustomMetric {
  const factory CustomMetric({
    required String id,
    required String name,
    required String formula,
    required String description,
    required List<String> dependencies,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required String createdBy,
    DateTime? lastModified,
    @Default({}) Map<String, dynamic> settings,
  }) = _CustomMetric;

  factory CustomMetric.fromJson(Map<String, dynamic> json) => _$CustomMetricFromJson(json);
}
