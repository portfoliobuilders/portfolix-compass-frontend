// ═══════════════════════════════════════════════════════════════════════════
// 📄 PORTFOLIX COMPASS - COMPLETE TYPE DEFINITIONS
// ═══════════════════════════════════════════════════════════════════════════

// Employee Types
export interface Employee {
  id: string;
  employeeId: string;
  name: string;
  email: string;
  phone: string;
  department: string;
  designation: string;
  dateOfJoining: Date;
  salaryType: 'standard' | 'sales';
  careerStage?: 'probation' | 'established';
  reportingManager?: string;
  companyId: string;
  status: 'active' | 'inactive' | 'on-leave';
  bankDetails?: {
    accountNumber: string;
    ifsc: string;
    accountHolder: string;
  };
  pfNumber?: string;
  esiNumber?: string;
}

// Salary Types
export interface SalaryStructure {
  id: string;
  type: 'standard' | 'sales';
  careerStage?: 'probation' | 'established';
}

export interface StandardSalary {
  basicSalary: number;
  hra: number;
  da: number;
  specialAllowance: number;
  otherAllowance: number;
  gross: number;
}

export interface StandardDeductions {
  pf: number;
  professionalTax: number;
  incomeTax: number;
  otherDeductions: number;
  total: number;
}

export interface StandardSalaryResult {
  type: 'standard';
  earnings: StandardSalary;
  deductions: StandardDeductions;
  net: number;
  annualCTC: number;
  monthlyLPA: number;
}

export interface SalesCommissionTier {
  tier: number;
  range: string;
  ratePerSale: number;
  salesCount: number;
  commission: number;
}

export interface SalesSalaryFixed {
  baseSalary: number;
  skillAllowance: number;
  medicalAllowance: number;
  wellnessAllowance: number;
  total: number;
}

export interface SalesSalaryVariable {
  salesCount: number;
  commissionTierBreakdown: SalesCommissionTier[];
  commission: number;
  bonuses: number;
  referralCount: number;
  referralBonus: number;
  total: number;
}

export interface SalesSalaryResult {
  type: 'sales';
  careerStage: 'probation' | 'established';
  fixed: SalesSalaryFixed;
  variable: SalesSalaryVariable;
  earnings: { gross: number };
  deductions: { welfareFund: number; communication: number; total: number };
  net: number;
  annualCTC: number;
  monthlyLPA: number;
}

export type SalaryCalculationResult = StandardSalaryResult | SalesSalaryResult;

// Payroll Types
export interface PayrollRecord {
  id: string;
  employeeId: string;
  month: string;
  year: number;
  basicSalary: number;
  grossEarnings: number;
  totalDeductions: number;
  netSalary: number;
  annualCTC: number;
  status: 'draft' | 'calculated' | 'processed' | 'paid';
  processedOn?: Date;
  processedBy?: string;
}

// Offer Letter Types
export interface OfferLetter {
  id: string;
  employeeId: string;
  employeeName: string;
  designation: string;
  department: string;
  dateOfJoining: Date;
  salaryStructure: 'standard' | 'sales';
  basicSalary: number;
  probationPeriod: string;
  location: string;
  manager: string;
  validUpto: Date;
  status: 'draft' | 'sent' | 'accepted' | 'rejected' | 'expired';
  createdOn: Date;
  generatedBy: string;
}

// Salary Slip Types
export interface SalarySlip {
  id: string;
  employeeId: string;
  month: string;
  year: number;
  earnings: Record<string, number>;
  deductions: Record<string, number>;
  gross: number;
  net: number;
  ytdEarnings: number;
  ytdDeductions: number;
  generatedOn: Date;
  status: 'draft' | 'generated' | 'sent' | 'viewed';
}

// Company Types
export interface Company {
  id: string;
  name: string;
  gstNumber: string;
  panNumber: string;
  registrationNumber: string;
  industry: string;
  location: string;
  hrContactEmail: string;
  hrContactPhone: string;
  complianceRegion: 'Kerala' | 'India' | 'Global';
  bankAccount?: {
    accountNumber: string;
    ifsc: string;
    bankName: string;
  };
  logo?: string;
  createdOn: Date;
}

// Report Types
export interface MonthlyPayrollReport {
  month: string;
  year: number;
  totalEmployees: number;
  totalGrossSalary: number;
  totalDeductions: number;
  totalNetSalary: number;
  departmentBreakdown: Record<string, number>;
  salaryTypeBreakdown: {
    standard: number;
    sales: number;
  };
  pfContributions: number;
  tdsCollected: number;
  ptLiability: number;
  complianceStatus: 'compliant' | 'non-compliant' | 'pending';
}

// Common Types
export interface ApiResponse<T> {
  status: 'success' | 'error';
  data?: T;
  error?: {
    code: string;
    message: string;
    details?: Record<string, unknown>;
  };
  metadata?: {
    timestamp: string;
    version: string;
  };
}

export interface PaginatedResponse<T> {
  data: T[];
  total: number;
  page: number;
  pageSize: number;
  hasMore: boolean;
}

export interface User {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'hr' | 'finance' | 'manager' | 'employee';
  companyId: string;
  permissions: string[];
  isActive: boolean;
  lastLogin?: Date;
  createdOn: Date;
}
