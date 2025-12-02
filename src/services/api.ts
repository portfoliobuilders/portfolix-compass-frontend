// ═══════════════════════════════════════════════════════════════════════════
// 🔗 PORTFOLIX COMPASS - API CLIENT
// ═══════════════════════════════════════════════════════════════════════════

import axios, { AxiosError, AxiosResponse } from 'axios';
import { ApiResponse } from '../types';

const API_BASE_URL =
  import.meta.env.VITE_API_BASE_URL || 'http://localhost:3000/api';

// Create axios instance
const apiClient = axios.create({
  baseURL: API_BASE_URL,
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor - Add auth token
apiClient.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor - Handle errors
apiClient.interceptors.response.use(
  (response: AxiosResponse) => response.data,
  (error: AxiosError<ApiResponse<unknown>>) => {
    if (error.response) {
      // Server responded with error
      const errorMessage =
        error.response.data?.error?.message || 'An error occurred';

      // Handle 401 Unauthorized
      if (error.response.status === 401) {
        localStorage.removeItem('token');
        window.location.href = '/login';
      }

      return Promise.reject(new Error(errorMessage));
    } else if (error.request) {
      // Request made but no response
      return Promise.reject(new Error('Network error. Please try again.'));
    } else {
      // Something else happened
      return Promise.reject(new Error('An unexpected error occurred'));
    }
  }
);

// API Methods
export const api = {
  // Auth
  auth: {
    login: (email: string, password: string) =>
      apiClient.post('/auth/login', { email, password }),
    register: (data: unknown) => apiClient.post('/auth/register', data),
    logout: () => apiClient.post('/auth/logout'),
    refreshToken: () => apiClient.post('/auth/refresh'),
  },

  // Employees
  employees: {
    list: (params?: unknown) => apiClient.get('/employees', { params }),
    get: (id: string) => apiClient.get(`/employees/${id}`),
    create: (data: unknown) => apiClient.post('/employees', data),
    update: (id: string, data: unknown) =>
      apiClient.put(`/employees/${id}`, data),
    delete: (id: string) => apiClient.delete(`/employees/${id}`),
  },

  // Salary Calculation
  salary: {
    calculateStandard: (data: unknown) =>
      apiClient.post('/salary/calculate-standard', data),
    calculateSales: (data: unknown) =>
      apiClient.post('/salary/calculate-sales', data),
  },

  // Salary Slips
  salarySlips: {
    generate: (data: unknown) => apiClient.post('/salary-slips/generate', data),
    list: (params?: unknown) => apiClient.get('/salary-slips', { params }),
    get: (id: string) => apiClient.get(`/salary-slips/${id}`),
    download: (id: string) => apiClient.get(`/salary-slips/${id}/download`),
  },

  // Payroll
  payroll: {
    process: (data: unknown) => apiClient.post('/payroll/process', data),
    getRegister: (params?: unknown) =>
      apiClient.get('/payroll/register', { params }),
    getSummary: (params?: unknown) =>
      apiClient.get('/payroll/summary', { params }),
    export: (id: string) => apiClient.get(`/payroll/${id}/export`),
  },

  // Offer Letters
  offerLetters: {
    create: (data: unknown) => apiClient.post('/offer-letters', data),
    get: (id: string) => apiClient.get(`/offer-letters/${id}`),
    download: (id: string) => apiClient.get(`/offer-letters/${id}/download`),
  },

  // Reports
  reports: {
    monthly: (month: string, year: number) =>
      apiClient.get('/reports/monthly', { params: { month, year } }),
    annual: (year: number) =>
      apiClient.get('/reports/annual', { params: { year } }),
    taxCompliance: (year: number) =>
      apiClient.get('/reports/tax-compliance', { params: { year } }),
  },

  // Companies
  companies: {
    list: () => apiClient.get('/companies'),
    get: (id: string) => apiClient.get(`/companies/${id}`),
    update: (id: string, data: unknown) =>
      apiClient.put(`/companies/${id}`, data),
  },
};

export default apiClient;
