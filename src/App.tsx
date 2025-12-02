import React, { useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { useStore } from './store/useStore';

// Layouts
import MainLayout from './layouts/MainLayout';
import AuthLayout from './layouts/AuthLayout';

// Auth Pages
import Login from './pages/auth/Login';
import Register from './pages/auth/Register';

// Dashboard
import Dashboard from './pages/Dashboard';

// Employee Pages
import EmployeeManagement from './pages/EmployeeManagement';
import EmployeeDetail from './pages/EmployeeDetail';

// Salary Pages
import SalaryBuilder from './pages/SalaryBuilder';
import OfferLetter from './pages/OfferLetter';
import SalarySlip from './pages/SalarySlip';

// Payroll Pages
import PayrollRegister from './pages/PayrollRegister';

// Reports
import Reports from './pages/Reports';

// Admin
import AdminSettings from './pages/AdminSettings';

const ProtectedRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { auth } = useStore();
  return auth.isAuthenticated ? <>{children}</> : <Navigate to="/login" />;
};

const App: React.FC = () => {
  const { auth, fetchCurrentUser } = useStore();

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (token) {
      fetchCurrentUser();
    }
  }, [fetchCurrentUser]);

  return (
    <Router>
      <Routes>
        {/* Auth Routes */}
        <Route element={<AuthLayout />}>
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
        </Route>

        {/* Protected Routes */}
        <Route
          element={
            <ProtectedRoute>
              <MainLayout />
            </ProtectedRoute>
          }
        >
          {/* Dashboard */}
          <Route path="/" element={<Dashboard />} />
          <Route path="/dashboard" element={<Dashboard />} />

          {/* Employees */}
          <Route path="/employees" element={<EmployeeManagement />} />
          <Route path="/employees/:id" element={<EmployeeDetail />} />

          {/* Salary */}
          <Route path="/salary-builder" element={<SalaryBuilder />} />
          <Route path="/offer-letter" element={<OfferLetter />} />
          <Route path="/salary-slip" element={<SalarySlip />} />

          {/* Payroll */}
          <Route path="/payroll-register" element={<PayrollRegister />} />

          {/* Reports */}
          <Route path="/reports" element={<Reports />} />

          {/* Admin */}
          <Route path="/admin/settings" element={<AdminSettings />} />
        </Route>

        {/* Catch all - redirect to dashboard */}
        <Route path="*" element={<Navigate to="/" />} />
      </Routes>
    </Router>
  );
};

export default App;
