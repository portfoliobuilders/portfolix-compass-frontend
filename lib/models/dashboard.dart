import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard.freezed.dart';
part 'dashboard.g.dart';

/// Dashboard statistics and overview data
@freezed
class DashboardStats with _$DashboardStats {
  const factory DashboardStats({
    required String companyId,
    required int totalEmployees,
    required int activeEmployees,
    required int onLeaveEmployees,
    required double totalMonthlyPayroll,
    required double totalDeductions,
    required double totalTaxes,
    required double averageSalary,
    required int attendanceRate,
    required int pendingApprovals,
    required DateTime lastUpdated,
  }) = _DashboardStats;

  factory DashboardStats.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsFromJson(json);
}

/// Dashboard chart data
@freezed
class DashboardChart with _$DashboardChart {
  const factory DashboardChart({
    required String id,
    required String title,
    required String type,
    required List<ChartDataPoint> data,
    String? unit,
    String? description,
  }) = _DashboardChart;

  factory DashboardChart.fromJson(Map<String, dynamic> json) =>
      _$DashboardChartFromJson(json);
}

/// Individual data point for charts
@freezed
class ChartDataPoint with _$ChartDataPoint {
  const factory ChartDataPoint({
    required String label,
    required double value,
    String? category,
  }) = _ChartDataPoint;

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) =>
      _$ChartDataPointFromJson(json);
}

/// Key Performance Indicator
@freezed
class KPI with _$KPI {
  const factory KPI({
    required String id,
    required String name,
    required double currentValue,
    required double targetValue,
    required String status,
    required double percentage,
    required String trend,
  }) = _KPI;

  factory KPI.fromJson(Map<String, dynamic> json) => _$KPIFromJson(json);
}

/// Dashboard overview combining all metrics
@freezed
class DashboardOverview with _$DashboardOverview {
  const factory DashboardOverview({
    required DashboardStats stats,
    required List<DashboardChart> charts,
    required List<KPI> kpis,
    required List<RecentActivity> recentActivities,
    required DateTime generatedAt,
  }) = _DashboardOverview;

  factory DashboardOverview.fromJson(Map<String, dynamic> json) =>
      _$DashboardOverviewFromJson(json);
}

/// Recent activity log item
@freezed
class RecentActivity with _$RecentActivity {
  const factory RecentActivity({
    required String id,
    required String title,
    required String description,
    required String type,
    required String performedBy,
    required DateTime timestamp,
  }) = _RecentActivity;

  factory RecentActivity.fromJson(Map<String, dynamic> json) =>
      _$RecentActivityFromJson(json);
}
