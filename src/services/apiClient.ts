import axios, { AxiosInstance, AxiosError } from 'axios';

export interface ApiResponse<T = any> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
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
      (response) => { this.retryCount = 0; return response; },
      async (error: AxiosError) => {
        if (error.response?.status === 401) {
          localStorage.removeItem('token');
          window.location.href = '/login';
          return Promise.reject(error);
        }
        if (!error.response && this.retryCount < 3) {
          this.retryCount++;
          await new Promise(r => setTimeout(r, 1000 * this.retryCount));
          return this.client((error.config as any)!);
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

  // EMPLOYEES
  employees = {
    list: (filters?: any) => this.request<any[]>('get', '/employees', undefined),
    get: (id: string) => this.request<any>('get', `/employees/${id}`),
    create: (data: any) => this.request<any>('post', '/employees', data),
    update: (id: string, data: any) => this.request<any>('put', `/employees/${id}`, data),
    delete: (id: string) => this.request<void>('delete', `/employees/${id}`),
  };

  // SALARY
  salary = {
    calculate: (input: any) => this.request<any>('post', '/salary/calculate', input),
    predict: (input: any) => this.request<string>('post', '/aiml/salary/predict', input),
  };

  // DOCUMENTS
  documents = {
    offerLetter: (input: any) => this.request<any>('post', '/documents/offer-letter', input),
    salarySlip: (input: any) => this.request<any>('post', '/documents/salary-slip', input),
  };

  // PAYROLL
  payroll = {
    register: (year: number, month: string) => this.request<any[]>('get', `/payroll/register/${year}/${month}`),
    process: (data: any) => this.request<void>('post', '/payroll/process', data),
  };

  // REPORTS
  reports = {
    monthly: (year: number, month: string) => this.request<any>('get', `/reports/monthly/${year}/${month}`),
    annual: (year: number) => this.request<any>('get', `/reports/annual/${year}`),
  };

  // HEALTH
  health = () => this.request<any>('get', '/health');
}

export const apiClient = new PortalixApiClient();
export default apiClient;
