import React, { useState } from 'react';
import { apiClient } from '../services/apiClient';

interface SalaryFormData {
  name: string;
  employeeId: string;
  department: string;
  designation: string;
  dateOfJoining: string;
  careerStage: string;
  numberOfSalesThisMonth: number;
  basicSalary: number;
  da: number;
  hra: number;
}

export const SalaryBuilder: React.FC = () => {
  const [formData, setFormData] = useState<SalaryFormData>({
    name: '',
    employeeId: '',
    department: '',
    designation: '',
    dateOfJoining: '',
    careerStage: 'Probation (Month 1-3)',
    numberOfSalesThisMonth: 0,
    basicSalary: 0,
    da: 0,
    hra: 0,
  });
  const [summary, setSummary] = useState<any>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: isNaN(Number(value)) ? value : Number(value),
    }));
  };

  const calculateSalary = async () => {
    setLoading(true);
    setError('');
    try {
      const grossSalary = formData.basicSalary + formData.da + formData.hra;
      const totalDeductions = (grossSalary * 0.15); // Approximate
      const netSalary = grossSalary - totalDeductions;

      setSummary({
        lpa: (netSalary * 12 / 100000).toFixed(2),
        grossSalary,
        netSalary,
        earnings: [
          { name: 'Basic', amount: formData.basicSalary },
          { name: 'DA', amount: formData.da },
          { name: 'HRA', amount: formData.hra },
        ],
        deductions: [
          { name: 'PF', amount: formData.basicSalary * 0.12 },
          { name: 'ESI', amount: 0 },
          { name: 'Income Tax', amount: Math.max(0, (grossSalary - 250000) * 0.1) },
        ],
      });
    } catch (err: any) {
      setError(err.message || 'Failed to calculate salary');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <div className="max-w-6xl mx-auto">
        {/* Form Section */}
        <div className="bg-white rounded-lg shadow-sm p-6 mb-6">
          <h2 className="text-xl font-semibold mb-6">Salary Builder</h2>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Employee Name</label>
              <input
                type="text"
                name="name"
                placeholder="Full Name"
                value={formData.name}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Employee ID</label>
              <input
                type="text"
                name="employeeId"
                placeholder="1234"
                value={formData.employeeId}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Department</label>
              <select
                name="department"
                value={formData.department}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option>Finance</option>
                <option>Engineering</option>
                <option>Sales</option>
                <option>HR</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Designation</label>
              <select
                name="designation"
                value={formData.designation}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option>Executive</option>
                <option>Manager</option>
                <option>Senior Developer</option>
                <option>Developer</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Date of Joining</label>
              <input
                type="date"
                name="dateOfJoining"
                value={formData.dateOfJoining}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Career Stage</label>
              <select
                name="careerStage"
                value={formData.careerStage}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option>Probation (Month 1-3)</option>
                <option>Confirmed (4+ Months)</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Basic Salary</label>
              <input
                type="number"
                name="basicSalary"
                value={formData.basicSalary}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">DA</label>
              <input
                type="number"
                name="da"
                value={formData.da}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">HRA</label>
              <input
                type="number"
                name="hra"
                value={formData.hra}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
          </div>

          <button
            onClick={calculateSalary}
            disabled={loading}
            className="w-full bg-gradient-to-r from-orange-400 to-orange-500 text-white font-semibold py-2 px-4 rounded-md hover:from-orange-500 hover:to-orange-600 disabled:opacity-50"
          >
            {loading ? 'Calculating...' : 'Calculate Salary'}
          </button>
        </div>

        {/* Summary Section */}
        {summary && (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div className="bg-gradient-to-r from-blue-50 to-blue-100 rounded-lg p-6">
              <p className="text-sm text-gray-600 mb-2">Annual LPA</p>
              <p className="text-3xl font-bold text-blue-600">₹{summary.lpa} LPA</p>
            </div>
            <div className="bg-white rounded-lg shadow-sm p-6">
              <h3 className="font-semibold text-gray-800 mb-4">Earnings</h3>
              <div className="space-y-2">
                {summary.earnings.map((item: any, idx: number) => (
                  <div key={idx} className="flex justify-between text-sm">
                    <span className="text-gray-600">{item.name}</span>
                    <span className="font-medium">₹{item.amount.toFixed(0)}</span>
                  </div>
                ))}
              </div>
            </div>
            <div className="bg-white rounded-lg shadow-sm p-6">
              <h3 className="font-semibold text-gray-800 mb-4">Deductions</h3>
              <div className="space-y-2">
                {summary.deductions.map((item: any, idx: number) => (
                  <div key={idx} className="flex justify-between text-sm">
                    <span className="text-gray-600">{item.name}</span>
                    <span className="font-medium text-red-600">₹{item.amount.toFixed(0)}</span>
                  </div>
                ))}
              </div>
            </div>
            <div className="bg-gradient-to-r from-green-50 to-green-100 rounded-lg p-6">
              <p className="text-sm text-gray-600 mb-2">Net Take-Home</p>
              <p className="text-3xl font-bold text-green-600">₹{(summary.netSalary / 12).toFixed(0)}</p>
            </div>
          </div>
        )}

        {error && (
          <div className="bg-red-50 border border-red-200 rounded-lg p-4 text-red-600 mt-4">
            {error}
          </div>
        )}
      </div>
    </div>
  );
};

export default SalaryBuilder;
