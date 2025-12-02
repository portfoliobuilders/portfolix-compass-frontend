import React from 'react';
import { useNavigate } from 'react-router-dom';

const NotFound: React.FC = () => {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-b from-gray-50 to-gray-100 p-6">
      <div className="text-center">
        <h1 className="text-9xl font-extrabold text-gray-900 mb-4">404</h1>
        <p className="text-3xl font-bold text-gray-800 mb-2">Page Not Found</p>
        <p className="text-lg text-gray-600 mb-8">Sorry, the page you are looking for does not exist.</p>
        <button
          onClick={() => navigate('/')}
          className="px-8 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors duration-200"
        >
          Go Back to Home
        </button>
      </div>
    </div>
  );
};

export default NotFound;
