import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';

const Sidebar: React.FC = () => {
  const [isOpen, setIsOpen] = useState(true);
  const location = useLocation();

  const menuItems = [
    {
      section: 'CORE TOOLS',
      items: [
        { label: 'Salary Builder', path: '/salary-builder', icon: '\ud83d\udcb0' },
        { label: 'Salary Slip', path: '/salary-slip', icon: '\ud83d\udccb', active: true },
        { label: 'Offer Letter', path: '/offer-letter', icon: '\ud83d\udcc4' },
      ],
    },
    {
      section: 'TEAM MANAGEMENT',
      items: [
        { label: 'Payroll Register', path: '/payroll-register', icon: '\ud83d\udc65' },
        { label: 'Compensation Tiers', path: '/admin/settings', icon: '\ud83d\udcc8' },
        { label: 'Policy & Benefits', path: '/admin/settings', icon: '\ud83d\udcc4' },
      ],
    },
    {
      section: 'REFERENCE',
      items: [
        { label: 'Documentation', path: '/docs', icon: '\ud83d\udcda' },
      ],
    },
  ];

  return (
    <aside className={`${isOpen ? 'w-64' : 'w-20'} bg-white border-r border-gray-200 transition-all duration-300 overflow-y-auto h-screen fixed left-0 top-0 z-40`}>
      <div className="p-4 border-b border-gray-200 flex items-center justify-between">
        {isOpen && (
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 bg-orange-500 rounded flex items-center justify-center text-white font-bold">P</div>
            <span className="font-bold text-orange-500">Compass</span>
          </div>
        )}
        <button onClick={() => setIsOpen(!isOpen)} className="p-1 hover:bg-gray-100 rounded">
          {isOpen ? '\u2190' : '\u2192'}
        </button>
      </div>

      <nav className="p-4 space-y-8">
        {menuItems.map((section, idx) => (
          <div key={idx}>
            {isOpen && <h3 className="text-xs font-semibold text-gray-500 mb-3 uppercase tracking-wide">{section.section}</h3>}
            <div className="space-y-2">
              {section.items.map((item, itemIdx) => (
                <Link
                  key={itemIdx}
                  to={item.path}
                  className={`flex items-center gap-3 px-4 py-2 rounded transition-colors ${
                    item.active ? 'bg-orange-500 text-white' : 'text-gray-700 hover:bg-gray-100'
                  }`}
                >
                  <span className="text-xl">{item.icon}</span>
                  {isOpen && <span className="text-sm font-medium">{item.label}</span>}
                </Link>
              ))}
            </div>
          </div>
        ))}
      </nav>
    </aside>
  );
};

export default Sidebar;
