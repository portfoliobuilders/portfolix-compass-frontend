'use client';

import React, { useState, useEffect } from 'react';
import { apiClient } from '@/services/apiClient';

interface Employee {
  id: string;
  name: string;
  email: string;
  position: string;
  department: string;
  salary: number;
  joinDate: string;
}

export default function EmployeeManagement() {
  const [employees, setEmployees] = useState<Employee[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [filterDept, setFilterDept] = useState('all');

  useEffect(() => {
    const fetchEmployees = async () => {
      try {
        setIsLoading(true);
        const response = await apiClient.employees.list();
        setEmployees(response.employees || []);
        setError(null);
      } catch (err) {
        setError('Failed to load employees');
        console.error(err);
      } finally {
        setIsLoading(false);
      }
    };

    fetchEmployees();
  }, []);

  const filteredEmployees = employees.filter(emp =>
    (emp.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
     emp.email.toLowerCase().includes(searchTerm.toLowerCase())) &&
    (filterDept === 'all' || emp.department === filterDept)
  );

  const departments = [...new Set(employees.map(e => e.department))];

  if (isLoading) {
    return <div className="p-8 text-center">Loading employees...</div>;
  }

  if (error) {
    return <div className="p-8 text-red-600">{error}</div>;
  }

  return (
    <div className="p-8 bg-white">
      <div className="mb-8">
        <h1 className="text-3xl font-bold mb-6 text-gray-900">Employee Management</h1>
        
        <div className="flex gap-4 mb-6">
          <input
            type="text"
            placeholder="Search employees..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="px-4 py-2 border border-gray-300 rounded-lg flex-1 focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          <select
            value={filterDept}
            onChange={(e) => setFilterDept(e.target.value)}
            className="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
          >
            <option value="all">All Departments</option>
            {departments.map(dept => (
              <option key={dept} value={dept}>{dept}</option>
            ))}
          </select>
        </div>
      </div>

      <div className="overflow-x-auto">
        <table className="w-full border-collapse">
          <thead className="bg-gray-100">
            <tr>
              <th className="px-4 py-3 text-left font-semibold text-gray-700">Name</th>
              <th className="px-4 py-3 text-left font-semibold text-gray-700">Email</th>
              <th className="px-4 py-3 text-left font-semibold text-gray-700">Position</th>
              <th className="px-4 py-3 text-left font-semibold text-gray-700">Department</th>
              <th className="px-4 py-3 text-left font-semibold text-gray-700">Salary</th>
              <th className="px-4 py-3 text-left font-semibold text-gray-700">Join Date</th>
              <th className="px-4 py-3 text-left font-semibold text-gray-700">Actions</th>
            </tr>
          </thead>
          <tbody>
            {filteredEmployees.length > 0 ? (
              filteredEmployees.map(emp => (
                <tr key={emp.id} className="border-b border-gray-200 hover:bg-gray-50">
                  <td className="px-4 py-3 text-gray-900">{emp.name}</td>
                  <td className="px-4 py-3 text-gray-700">{emp.email}</td>
                  <td className="px-4 py-3 text-gray-700">{emp.position}</td>
                  <td className="px-4 py-3 text-gray-700">{emp.department}</td>
                  <td className="px-4 py-3 text-gray-700">₹{emp.salary.toLocaleString()}</td>
                  <td className="px-4 py-3 text-gray-700">{new Date(emp.joinDate).toLocaleDateString()}</td>
                  <td className="px-4 py-3">
                    <button className="text-blue-600 hover:text-blue-900 mr-3">Edit</button>
                    <button className="text-red-600 hover:text-red-900">Delete</button>
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan={7} className="px-4 py-8 text-center text-gray-500">No employees found</td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      <div className="mt-8 text-sm text-gray-600">
        Showing {filteredEmployees.length} of {employees.length} employees
      </div>
    </div>
  );
}
