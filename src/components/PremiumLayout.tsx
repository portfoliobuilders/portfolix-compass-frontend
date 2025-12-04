'use client';

import React, { ReactNode } from 'react';
import Sidebar from './Sidebar';
import Header from './Header';

export default function PremiumLayout({ children }: { children: ReactNode }) {
  return (
    <div className="flex h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-slate-100">
      <Sidebar />
      <div className="flex-1 flex flex-col backdrop-blur-sm">
        <Header />
        <main className="flex-1 overflow-auto bg-gradient-to-b from-transparent to-slate-50">
          <div className="animate-fadeIn">{children}</div>
        </main>
      </div>
    </div>
  );
}
