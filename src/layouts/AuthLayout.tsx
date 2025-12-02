import React from 'react';
import { Outlet } from 'react-router-dom';

const AuthLayout: React.FC = () => {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-teal-50 to-teal-100">
      <div className="w-full max-w-md">
        <div className="bg-white rounded-lg shadow-lg p-8 animate-slide-up">
          {/* Logo/Brand */}
          <div className="mb-8 text-center">
            <h1 className="text-3xl font-bold text-teal-600 mb-2">Portfolix Compass</h1>
            <p className="text-gray-600 text-sm">Salary & Compensation Management</p>
          </div>

          {/* Auth Content */}
          <Outlet />
        </div>

        {/* Footer */}
        <div className="mt-8 text-center text-sm text-gray-600">
          <p>© 2024 Portfolix Compass. All rights reserved.</p>
        </div>
      </div>
    </div>
  );
};

export default AuthLayout;
