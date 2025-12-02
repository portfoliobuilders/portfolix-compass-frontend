import React from 'react';
import { Link } from 'react-router-dom';
import { Menu, Bell, Settings, LogOut } from 'lucide-react';
import { useStore } from '../store';

interface HeaderProps {
  onMenuClick?: () => void;
}

const Header: React.FC<HeaderProps> = ({ onMenuClick }) => {
  const { user, logout } = useStore();

  const handleLogout = () => {
    logout();
    window.location.href = '/login';
  };

  return (
    <header className="bg-white border-b border-gray-200 sticky top-0 z-40">
      <div className="px-6 py-4 flex items-center justify-between">
        {/* Left Section - Logo & Menu */}
        <div className="flex items-center gap-4">
          <button
            onClick={onMenuClick}
            className="lg:hidden p-2 hover:bg-gray-100 rounded-lg transition-colors"
            aria-label="Toggle menu"
          >
            <Menu className="w-6 h-6 text-gray-600" />
          </button>
          <Link
            to="/"
            className="text-xl font-bold text-blue-600 hover:text-blue-700 transition-colors"
          >
            Portfolix Compass
          </Link>
        </div>

        {/* Right Section - Actions */}
        <div className="flex items-center gap-6">
          {/* Notifications */}
          <button
            className="relative p-2 text-gray-600 hover:bg-gray-100 rounded-lg transition-colors"
            aria-label="Notifications"
          >
            <Bell className="w-6 h-6" />
            <span className="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
          </button>

          {/* Settings */}
          <Link
            to="/settings"
            className="p-2 text-gray-600 hover:bg-gray-100 rounded-lg transition-colors"
            aria-label="Settings"
          >
            <Settings className="w-6 h-6" />
          </Link>

          {/* Divider */}
          <div className="w-px h-6 bg-gray-200"></div>

          {/* User Profile & Logout */}
          <div className="flex items-center gap-3">
            {user && (
              <>
                <div className="flex flex-col items-end">
                  <p className="text-sm font-medium text-gray-900">
                    {user.name || 'User'}
                  </p>
                  <p className="text-xs text-gray-500">
                    {user.email || 'user@example.com'}
                  </p>
                </div>
                <div className="w-10 h-10 bg-blue-600 rounded-full flex items-center justify-center">
                  <span className="text-white font-semibold text-sm">
                    {(user.name || 'U')[0].toUpperCase()}
                  </span>
                </div>
              </>
            )}
            <button
              onClick={handleLogout}
              className="ml-4 p-2 text-gray-600 hover:bg-red-50 hover:text-red-600 rounded-lg transition-colors"
              aria-label="Logout"
            >
              <LogOut className="w-6 h-6" />
            </button>
          </div>
        </div>
      </div>
    </header>
  );
};

export default Header;
