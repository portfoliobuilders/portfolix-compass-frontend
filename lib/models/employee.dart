import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

/// Employee model representing an employee in the system
@freezed
class Employee with _$Employee {
  const factory Employee({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String department,
    required String designation,
    required String employeeId,
    required double salary,
    required String status,
    required String companyId,
    String? phone,
    String? address,
    String? profileImage,
    DateTime? dateOfJoining,
    DateTime? dateOfBirth,
    String? bankAccount,
    String? bankName,
    String? panNumber,
    String? aadharNumber,
    int? reportingTo,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  const Employee._();

  String get fullName => '$firstName $lastName';
  bool get isActive => status == 'active';
  bool get isOnLeave => status == 'on_leave';
}

/// Employee salary structure
@freezed
class SalaryStructure with _$SalaryStructure {
  const factory SalaryStructure({
    required String id,
    required String employeeId,
    required double baseSalary,
    required double hra,
    required double da,
    required double conveyance,
    required double medical,
    required double other,
    required double deductions,
    required double pf,
    required double esi,
    required double professionalTax,
    required double incomeTax,
    required DateTime effectiveFrom,
    DateTime? effectiveTo,
    required DateTime createdAt,
  }) = _SalaryStructure;

  factory SalaryStructure.fromJson(Map<String, dynamic> json) =>
      _$SalaryStructureFromJson(json);

  const SalaryStructure._();

  double get grossSalary =>
      baseSalary + hra + da + conveyance + medical + other;
  double get totalDeductions => pf + esi + professionalTax + incomeTax;
  double get netSalary => grossSalary - totalDeductions;
}

/// Employee attendance record
@freezed
class Attendance with _$Attendance {
  const factory Attendance({
    required String id,
    required String employeeId,
    required DateTime date,
    required String status,
    String? checkInTime,
    String? checkOutTime,
    String? remarks,
  }) = _Attendance;

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
}

/// Employee leave request
@freezed
class LeaveRequest with _$LeaveRequest {
  const factory LeaveRequest({
    required String id,
    required String employeeId,
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required int numberOfDays,
    required String reason,
    required String status,
    String? approvedBy,
    String? remarks,
    required DateTime createdAt,
  }) = _LeaveRequest;

  factory LeaveRequest.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestFromJson(json);
}
