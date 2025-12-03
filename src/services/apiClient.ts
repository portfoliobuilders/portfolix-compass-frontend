import axios, { AxiosInstance, AxiosError } from 'axios';

export interface ApiResponse<T = any> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
}

interface RequestOptions {
  method: 'get' | 'post' | 'put' | 'delete';
  url: string;
  data?: any;
}

class PortalixApiClient {
  private client: AxiosInstance;
  private retryCount = 0;

  constructor() {
    const baseURL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:5000/api';

    this.client = axios.create({
      baseURL,
      timeout: 30000,
      headers: { 'Content-Type': 'application/json' },
    });

    this.setupInterceptors();
  }

  private setupInterceptors() {
    this.client.interceptors.request.use((config) => {
      const token = localStorage.getItem('token');
      if (token) config.headers.Authorization = `Bearer ${token}`;
      return config;
    });

    this.client.interceptors.response.use(
      (response) => {
        this.retryCount = 0;
        return response;
      },
      async (error: AxiosError) => {
        if (error.response?.status === 401) {
          localStorage.removeItem('token');
          window.location.href = '/login';
        }
        return Promise.reject(error);
      }
    );
  }

  private async request<T>(
    method: 'get' | 'post' | 'put' | 'delete',
    url: string,
    data?: any
  ): Promise<ApiResponse<T>> {
    try {
      const response = await this.client[method]<ApiResponse<T>>(url, data);
      return response.data;
    } catch (error) {
      if (axios.isAxiosError(error)) {
        return {
          success: false,
          error: error.response?.data?.error || error.message,
          message: error.response?.data?.message,
        };
      }
      throw error;
    }
  }

  // ============== SALARY & COMPENSATION ==============
  
  // 1. Salary Prediction
  async predictSalary(data: {
    employeeId: string;
    currentSalary: number;
    experience: number;
    performanceRating: number;
    designation: string;
    marketRate: number;
    companyGrowth: number;
    inflationRate: number;
  }): Promise<ApiResponse<{ prediction: string }>> {
    return this.request('post', '/aiml/salary/predict', data);
  }

  // 2. Offer Letter Generation
  async generateOfferLetter(data: {
    name: string;
    position: string;
    department: string;
    salary: number;
    joiningDate: string;
    location: string;
    benefits: string;
  }): Promise<ApiResponse<{ offerLetter: string }>> {
    return this.request('post', '/aiml/documents/offer-letter', data);
  }

  // 3. Salary Slip Generation
  async generateSalarySlip(data: {
    name: string;
    designation: string;
    department: string;
    basicSalary: number;
    da: number;
    hra: number;
    grossSalary: number;
    incomeTax: number;
    professionalTax: number;
    pf: number;
    totalDeductions: number;
    netSalary: number;
    month: string;
  }): Promise<ApiResponse<{ slip: string }>> {
    return this.request('post', '/aiml/documents/salary-slip', data);
  }

  // 4. Compensation Parity Analysis
  async analyzeCompensationParity(data: {
    employees: Array<{
      id: string;
      salary: number;
      experience: number;
      gender: string;
    }>;
  }): Promise<ApiResponse<{ analysis: string }>> {
    return this.request('post', '/aiml/compensation/parity-analysis', data);
  }

  // 5. Market Benchmarking
  async benchmarkSalary(data: {
    role: string;
    location: string;
    experience: number;
  }): Promise<ApiResponse<{ benchmark: string }>> {
    return this.request('post', '/aiml/compensation/market-benchmark', data);
  }

  // ============== TAX & COMPLIANCE ==============
  
  // 6. Tax Optimization Strategy
  async optimizeTaxStrategy(data: {
    employeeId: string;
    annualSalary: number;
    age: number;
    professionalTaxAmount: number;
    taxRegime: string;
    investments: string;
  }): Promise<ApiResponse<{ strategy: string }>> {
    return this.request('post', '/aiml/tax/optimize-strategy', data);
  }

  // 7. Compliance Check
  async checkCompliance(data: {
    organizationId: string;
    name: string;
    employeeCount: number;
    industry: string;
  }): Promise<ApiResponse<{ compliance: string }>> {
    return this.request('post', '/aiml/compliance/check', data);
  }

  // ============== PAYROLL & ANALYTICS ==============
  
  // 8. Anomaly Detection
  async detectAnomalies(data: {
    employees: Array<{
      employeeId: string;
      salary: number;
      lastSalary: number;
      overtimePay: number;
    }>;
  }): Promise<ApiResponse<{ anomalies: string }>> {
    return this.request('post', '/aiml/payroll/detect-anomalies', data);
  }

  // 9. Employee Insights
  async generateEmployeeInsights(data: {
    employeeId: string;
    careerHistory: any[];
    performanceData: any[];
    salaryProgression: any[];
  }): Promise<ApiResponse<{ insights: string }>> {
    return this.request('post', '/aiml/employee/insights', data);
  }

  // 10. Performance Recommendations
  async getPerformanceRecommendations(data: {
    employeeId: string;
    performanceRating: number;
    skills: string[];
    yearsInRole: number;
  }): Promise<ApiResponse<{ recommendations: string }>> {
    return this.request('post', '/aiml/employee/performance-recommendations', data);
  }

  // 11. Bulk Payroll Analysis
  async analyzeBulkPayroll(data: {
    payrollList: Array<{
      employeeId: string;
      grossSalary: number;
      netSalary: number;
      department: string;
    }>;
  }): Promise<ApiResponse<{ analysis: string }>> {
    return this.request('post', '/aiml/payroll/bulk-analysis', data);
  }

  // 12. Health Check
  async healthCheck(): Promise<ApiResponse<{ status: string; service: string; features: string[] }>> {
    return this.request('get', '/aiml/health');
  }

  // ============== EMPLOYEE MANAGEMENT ==============
  
  employees = {
    list: (filters?: any) => this.request<any[]>('get', '/employees', undefined),
    get: (id: string) => this.request<any>('get', `/employees/${id}`),
    create: (data: any) => this.request<any>('post', '/employees', data),
    update: (id: string, data: any) => this.request<any>('put', `/employees/${id}`, data),
    delete: (id: string) => this.request<void>('delete', `/employees/${id}`),
  };
}

export const apiClient = new PortalixApiClient();
export default apiClient;
