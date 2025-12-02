'use client';
import React, { useState, useEffect } from 'react';
import { apiClient } from '@/services/apiClient';
interface Slip {
  id: string;
  employeeId: string;
  employeeName: string;
  month: string;
  year: number;
  basicSalary: number;
  deductions: number;
  netAmount: number;
}
export default function SalarySlip() {
  const [slips, setSlips] = useState<Slip[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [selectedMonth, setSelectedMonth] = useState(new Date().toISOString().slice(0, 7));
  useEffect(() => {
    const fetchSlips = async () => {
      try {
        const response = await apiClient.salarySlips.list();
        setSlips(response.slips || []);
      } catch (err) {
        console.error(err);
      } finally {
        setIsLoading(false);
      }
    };
    fetchSlips();
  }, []);
  const handleBulkGenerate = async () => {
    try {
      await apiClient.salarySlips.generateBulk(selectedMonth);
      alert('Salary slips generated!');
    } catch (err) {
      alert('Failed to generate slips');
    }
  };
  if (isLoading) return <div className="p-8 text-center">Loading...</div>;
  return (
    <div className="p-8 bg-white">
      <h1 className="text-3xl font-bold mb-8 text-gray-900">Salary Slips</h1>
      <div className="mb-6 bg-gray-50 p-4 rounded-lg flex gap-4 items-end">
        <div>
          <label className="block text-sm font-semibold text-gray-700 mb-2">Month</label>
          <input type="month" value={selectedMonth} onChange={(e) => setSelectedMonth(e.target.value)} className="px-4 py-2 border border-gray-300 rounded" />
        </div>
        <button onClick={handleBulkGenerate} className="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded font-semibold">Generate</button>
      </div>
      <div className="overflow-x-auto">
        <table className="w-full">
          <thead className="bg-gray-100">
            <tr>
              <th className="px-4 py-3 text-left font-semibold">Employee</th>
              <th className="px-4 py-3 text-left font-semibold">Month</th>
              <th className="px-4 py-3 text-left font-semibold">Basic</th>
              <th className="px-4 py-3 text-left font-semibold">Deductions</th>
              <th className="px-4 py-3 text-left font-semibold">Net</th>
              <th className="px-4 py-3 text-left font-semibold">Action</th>
            </tr>
          </thead>
          <tbody>
            {slips.map(slip => (
              <tr key={slip.id} className="border-b hover:bg-gray-50">
                <td className="px-4 py-3">{slip.employeeName}</td>
                <td className="px-4 py-3">{slip.month}/{slip.year}</td>
                <td className="px-4 py-3">₹{slip.basicSalary}</td>
                <td className="px-4 py-3">₹{slip.deductions}</td>
                <td className="px-4 py-3 font-semibold">₹{slip.netAmount}</td>
                <td className="px-4 py-3"><button className="text-blue-600">Download</button></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
