import React, { useEffect, useState } from 'react';
import { apiClient } from '@/services/apiClient';

const Dashboard: React.FC = () => {
  const [employees, setEmployees] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await apiClient.employees.list();
        if (res.success && res.data) {
          setEmployees(res.data);
        }
      } catch (err) {
        setError('Failed to load dashboard data');
      } finally {
        setIsLoading(false);
      }
    };
    fetchData();
  }, []);

  if (isLoading) return <div className="p-8">Loading...</div>;
  if (error) return <div className="p-8 text-red-600">{error}</div>;

  return (
    <div className="p-8 bg-white">
      <h1 className="text-3xl font-bold mb-8 text-gray-900">Dashboard</h1>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div className="bg-gradient-to-br from-red-500 to-red-600 text-white p-6 rounded-lg shadow">
          <h3 className="text-sm font-semibold opacity-90">Total Employees</h3>
          <p className="text-4xl font-bold mt-2">{employees.length}</p>
        </div>
        <div className="bg-gradient-to-br from-blue-500 to-blue-600 text-white p-6 rounded-lg shadow">
          <h3 className="text-sm font-semibold opacity-90">This Month Cost</h3>
          <p className="text-4xl font-bold mt-2">₹0</p>
        </div>
        <div className="bg-gradient-to-br from-green-500 to-green-600 text-white p-6 rounded-lg shadow">
          <h3 className="text-sm font-semibold opacity-90">Payroll Status</h3>
          <p className="text-2xl font-bold mt-2">Pending</p>
        </div>
      </div>
      <div className="bg-gray-50 p-6 rounded-lg">
        <h2 className="text-xl font-semibold mb-4">Recent Employees</h2>
        <p className="text-gray-600">{employees.length} employees in system</p>
      </div>
    </div>
  );
};

export default Dashboard;
