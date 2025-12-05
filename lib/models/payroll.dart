import 'package:freezed_annotation/freezed_annotation.dart';

part 'payroll.freezed.dart';
part 'payroll.g.dart';

/// Payroll run model for processing employee salaries
@freezed
class PayrollRun with _$PayrollRun {
  const factory PayrollRun({
    required String id,
    required String companyId,
    required DateTime month,
    required String status,
    required int totalEmployees,
    required double totalGrossSalary,
    required double totalDeductions,
    required double totalNetSalary,
    required DateTime createdAt,
    required DateTime processedAt,
    String? approvedBy,
    DateTime? approvedAt,
  }) = _PayrollRun;

  factory PayrollRun.fromJson(Map<String, dynamic> json) =>
      _$PayrollRunFromJson(json);

  const PayrollRun._();

  bool get isProcessed => status == 'processed';
  bool get isApproved => status == 'approved';
  bool get isPaid => status == 'paid';
}

/// Individual payslip for an employee
@freezed
class Payslip with _$Payslip {
  const factory Payslip({
    required String id,
    required String employeeId,
    required String payrollRunId,
    required DateTime month,
    required double baseSalary,
    required double earnings,
    required double deductions,
    required double netPay,
    required Map<String, double> breakup,
    String? bankAccountNumber,
    String? bankName,
    required DateTime createdAt,
  }) = _Payslip;

  factory Payslip.fromJson(Map<String, dynamic> json) =>
      _$PayslipFromJson(json);
}

/// Tax calculation model
@freezed
class TaxCalculation with _$TaxCalculation {
  const factory TaxCalculation({
    required String id,
    required String employeeId,
    required DateTime financialYear,
    required double grossIncome,
    required double standardDeduction,
    required double taxableIncome,
    required double taxAmount,
    required double surcharge,
    required double cess,
    required double totalTax,
    required String taxRegime,
    required DateTime calculatedAt,
  }) = _TaxCalculation;

  factory TaxCalculation.fromJson(Map<String, dynamic> json) =>
      _$TaxCalculationFromJson(json);

  const TaxCalculation._();

  double get totalDeduction => taxAmount + surcharge + cess;
}

/// Payroll history/archive
@freezed
class PayrollHistory with _$PayrollHistory {
  const factory PayrollHistory({
    required String id,
    required String employeeId,
    required DateTime month,
    required String action,
    required String performedBy,
    required DateTime timestamp,
    Map<String, dynamic>? changes,
  }) = _PayrollHistory;

  factory PayrollHistory.fromJson(Map<String, dynamic> json) =>
      _$PayrollHistoryFromJson(json);
}
