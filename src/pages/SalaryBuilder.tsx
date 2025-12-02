'use client';

import React, { useState, useEffect } from 'react';
import { apiClient } from '@/services/apiClient';

interface SalaryStructure {
  id: string;
  name: string;
  components: {
    basic: number;
    hra: number;
    da: number;
    other: number;
  };
}

export default function SalaryBuilder() {
  const [structures, setStructures] = useState<SalaryStructure[]>([]);
  const [selectedStructure, setSelectedStructure] = useState<SalaryStructure | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [formData, setFormData] = useState({
    basic: 0,
    hra: 0,
    da: 0,
    other: 0
  });

  useEffect(() => {
    const fetchStructures = async () => {
      try {
        setIsLoading(true);
        const response = await apiClient.salaryStructures.list();
        setStructures(response.structures || []);
        setError(null);
      } catch (err) {
        setError('Failed to load salary structures');
        console.error(err);
      } finally {
        setIsLoading(false);
      }
    };

    fetchStructures();
  }, []);

  const totalSalary = formData.basic + formData.hra + formData.da + formData.other;

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: parseFloat(value) || 0 }));
  };

  const handleSelectStructure = (struct: SalaryStructure) => {
    setSelectedStructure(struct);
    setFormData(struct.components);
  };

  const handleSaveStructure = async () => {
    try {
      await apiClient.salaryStructures.create({
        name: `Structure-${Date.now()}`,
        components: formData
      });
      alert('Salary structure saved successfully!');
    } catch (err) {
      alert('Failed to save structure');
    }
  };

  if (isLoading) return <div className="p-8 text-center">Loading...</div>;

  return (
    <div className="p-8 bg-white">
      <h1 className="text-3xl font-bold mb-8 text-gray-900">Salary Builder</h1>

      <div className="grid grid-cols-2 gap-8">
        <div>
          <h2 className="text-xl font-semibold mb-4 text-gray-800">Predefined Structures</h2>
          <div className="space-y-2 bg-gray-50 p-4 rounded-lg">
            {structures.length > 0 ? (
              structures.map(struct => (
                <button
                  key={struct.id}
                  onClick={() => handleSelectStructure(struct)}
                  className={`w-full p-3 text-left rounded border-l-4 ${
                    selectedStructure?.id === struct.id
                      ? 'border-blue-600 bg-blue-50'
                      : 'border-gray-300 bg-white hover:bg-gray-50'
                  }`}
                >
                  <div className="font-semibold text-gray-900">{struct.name}</div>
                  <div className="text-sm text-gray-600">₹{(struct.components.basic + struct.components.hra + struct.components.da + struct.components.other).toLocaleString()}</div>
                </button>
              ))
            ) : (
              <p className="text-gray-500">No structures available</p>
            )}
          </div>
        </div>

        <div>
          <h2 className="text-xl font-semibold mb-4 text-gray-800">Customize Salary</h2>
          <div className="space-y-4 bg-gray-50 p-6 rounded-lg">
            {Object.entries(formData).map(([key, value]) => (
              <div key={key}>
                <label className="block text-sm font-semibold text-gray-700 mb-1 capitalize">{key}</label>
                <input
                  type="number"
                  name={key}
                  value={value}
                  onChange={handleChange}
                  className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
            ))}
            
            <div className="bg-gradient-to-r from-blue-500 to-blue-600 p-4 rounded-lg mt-6">
              <p className="text-white text-sm mb-2">Total Monthly Salary</p>
              <p className="text-white text-3xl font-bold">₹{totalSalary.toLocaleString()}</p>
            </div>

            <div className="grid grid-cols-2 gap-2 mt-6">
              <button
                onClick={handleSaveStructure}
                className="bg-green-600 hover:bg-green-700 text-white font-semibold py-2 px-4 rounded"
              >
                Save Structure
              </button>
              <button
                onClick={() => setFormData({ basic: 0, hra: 0, da: 0, other: 0 })}
                className="bg-gray-400 hover:bg-gray-500 text-white font-semibold py-2 px-4 rounded"
              >
                Reset
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
