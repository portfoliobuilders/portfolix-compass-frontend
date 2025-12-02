'use client';
import React, { useState } from 'react';
import { apiClient } from '@/services/apiClient';
interface OfferData {
  candidateName: string;
  position: string;
  department: string;
  salary: number;
  startDate: string;
  joiningBonus: number;
}
export default function OfferLetter() {
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState<OfferData>({
    candidateName: '',
    position: '',
    department: '',
    salary: 0,
    startDate: '',
    joiningBonus: 0
  });
  const [loading, setLoading] = useState(false);
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: isNaN(parseFloat(value)) ? value : parseFloat(value) }));
  };
  const handleGeneratePDF = async () => {
    try {
      setLoading(true);
      await apiClient.offerLetters.generate(formData);
      alert('Offer Letter generated successfully!');
    } catch (err) {
      alert('Failed to generate offer letter');
    } finally {
      setLoading(false);
    }
  };
  return (
    <div className="p-8 bg-white">
      <h1 className="text-3xl font-bold mb-8 text-gray-900">Generate Offer Letter</h1>
      <div className="max-w-2xl mx-auto">
        <div className="flex justify-between mb-8">
          {[1, 2, 3].map(s => (
            <div key={s} className={`flex-1 h-1 mx-2 rounded ${s <= step ? 'bg-blue-600' : 'bg-gray-300'}`} />
          ))}
        </div>
        {step === 1 && (
          <div className="space-y-4 bg-gray-50 p-6 rounded-lg">
            <h2 className="text-xl font-semibold text-gray-900 mb-4">Candidate Information</h2>
            <input type="text" name="candidateName" placeholder="Full Name" value={formData.candidateName} onChange={handleChange} className="w-full px-4 py-2 border border-gray-300 rounded" />
            <input type="text" name="position" placeholder="Position" value={formData.position} onChange={handleChange} className="w-full px-4 py-2 border border-gray-300 rounded" />
            <input type="text" name="department" placeholder="Department" value={formData.department} onChange={handleChange} className="w-full px-4 py-2 border border-gray-300 rounded" />
          </div>
        )}
        {step === 2 && (
          <div className="space-y-4 bg-gray-50 p-6 rounded-lg">
            <h2 className="text-xl font-semibold text-gray-900 mb-4">Compensation</h2>
            <input type="number" name="salary" placeholder="Annual Salary" value={formData.salary} onChange={handleChange} className="w-full px-4 py-2 border border-gray-300 rounded" />
            <input type="number" name="joiningBonus" placeholder="Joining Bonus" value={formData.joiningBonus} onChange={handleChange} className="w-full px-4 py-2 border border-gray-300 rounded" />
            <input type="date" name="startDate" value={formData.startDate} onChange={handleChange} className="w-full px-4 py-2 border border-gray-300 rounded" />
          </div>
        )}
        {step === 3 && (
          <div className="bg-gray-50 p-6 rounded-lg">
            <h2 className="text-xl font-semibold text-gray-900 mb-4">Review & Generate</h2>
            <div className="space-y-2 text-gray-800 mb-6">
              <p><strong>Name:</strong> {formData.candidateName}</p>
              <p><strong>Position:</strong> {formData.position}</p>
              <p><strong>Department:</strong> {formData.department}</p>
              <p><strong>Salary:</strong> ₹{formData.salary.toLocaleString()}</p>
              <p><strong>Joining Bonus:</strong> ₹{formData.joiningBonus.toLocaleString()}</p>
              <p><strong>Start Date:</strong> {formData.startDate}</p>
            </div>
          </div>
        )}
        <div className="flex justify-between mt-8">
          <button onClick={() => setStep(Math.max(1, step - 1))} disabled={step === 1} className="px-6 py-2 bg-gray-400 hover:bg-gray-500 disabled:opacity-50 text-white rounded font-semibold">Previous</button>
          {step < 3 ? (
            <button onClick={() => setStep(step + 1)} className="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded font-semibold">Next</button>
          ) : (
            <button onClick={handleGeneratePDF} disabled={loading} className="px-6 py-2 bg-green-600 hover:bg-green-700 disabled:opacity-50 text-white rounded font-semibold">{loading ? 'Generating...' : 'Generate PDF'}</button>
          )}
        </div>
      </div>
    </div>
  );
}
