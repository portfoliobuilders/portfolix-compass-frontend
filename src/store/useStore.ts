// ═══════════════════════════════════════════════════════════════════════════
// 🔐 PORTFOLIX COMPASS - GLOBAL STATE MANAGEMENT (ZUSTAND)
// ═══════════════════════════════════════════════════════════════════════════

import { create } from 'zustand';
import { User, Company, Employee } from '../types';

interface AppState {
  // Auth
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
  setUser: (user: User | null) => void;
  setToken: (token: string | null) => void;
  logout: () => void;

  // Company
  currentCompany: Company | null;
  companies: Company[];
  setCurrentCompany: (company: Company | null) => void;
  setCompanies: (companies: Company[]) => void;

  // Employees
  employees: Employee[];
  selectedEmployees: string[];
  setEmployees: (employees: Employee[]) => void;
  toggleEmployeeSelection: (employeeId: string) => void;
  clearEmployeeSelection: () => void;

  // UI State
  sidebarOpen: boolean;
  toggleSidebar: () => void;
  notificationCount: number;
  incrementNotifications: () => void;
  resetNotifications: () => void;

  // Loading & Error
  isLoading: boolean;
  error: string | null;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
}

export const useStore = create<AppState>((set) => ({
  // Auth
  user: null,
  token: localStorage.getItem('token'),
  isAuthenticated: !!localStorage.getItem('token'),
  setUser: (user) => set({ user }),
  setToken: (token) => {
    if (token) {
      localStorage.setItem('token', token);
    } else {
      localStorage.removeItem('token');
    }
    set({ token, isAuthenticated: !!token });
  },
  logout: () => {
    localStorage.removeItem('token');
    set({ user: null, token: null, isAuthenticated: false });
  },

  // Company
  currentCompany: null,
  companies: [],
  setCurrentCompany: (company) => set({ currentCompany: company }),
  setCompanies: (companies) => set({ companies }),

  // Employees
  employees: [],
  selectedEmployees: [],
  setEmployees: (employees) => set({ employees }),
  toggleEmployeeSelection: (employeeId) =>
    set((state) => ({
      selectedEmployees: state.selectedEmployees.includes(employeeId)
        ? state.selectedEmployees.filter((id) => id !== employeeId)
        : [...state.selectedEmployees, employeeId],
    })),
  clearEmployeeSelection: () => set({ selectedEmployees: [] }),

  // UI
  sidebarOpen: true,
  toggleSidebar: () => set((state) => ({ sidebarOpen: !state.sidebarOpen })),
  notificationCount: 0,
  incrementNotifications: () =>
    set((state) => ({ notificationCount: state.notificationCount + 1 })),
  resetNotifications: () => set({ notificationCount: 0 }),

  // Loading & Error
  isLoading: false,
  error: null,
  setLoading: (isLoading) => set({ isLoading }),
  setError: (error) => set({ error }),
}));

export default useStore;
