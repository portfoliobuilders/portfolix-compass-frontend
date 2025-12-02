# 🎯 Portfolix Compass Frontend

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/portfoliobuilders/portfolix-compass-frontend)
[![React](https://img.shields.io/badge/react-18.2.0-61DAFB.svg)](https://react.dev)
[![TypeScript](https://img.shields.io/badge/typescript-5.3.3-3178C6.svg)](https://www.typescriptlang.org)
[![License](https://img.shields.io/badge/license-Proprietary-red.svg)](LICENSE)

**Production-grade React TypeScript frontend for Enterprise Compensation Management System**

🔗 **Backend Repository**: [portfolix-compass-backend](https://github.com/portfoliobuilders/portfolix-compass-backend)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Quick Start](#-quick-start)
- [Project Structure](#-project-structure)
- [Development](#-development)
- [Deployment](#-deployment)

---

## 🌟 Overview

Portfolix Compass Frontend is an enterprise-grade React application for comprehensive salary, payroll, and compensation management. Built with TypeScript, Tailwind CSS, and modern React patterns, it provides a seamless user experience for HR teams and employees.

### Key Capabilities

- ✅ **Multi-tenant Architecture** - Support multiple organizations
- ✅ **Employee Management** - Complete CRUD operations
- ✅ **Salary Builder** - Dual structure (Standard + Sales)
- ✅ **Offer Letter Generator** - 3-step wizard with PDF export
- ✅ **Salary Slip Generation** - Professional branded documents
- ✅ **Payroll Register** - Batch processing with inline editing
- ✅ **Reports & Analytics** - Comprehensive insights
- ✅ **Admin Settings** - Configuration management

---

## ⚡ Features

### Core Functionality

- 🎨 **Modern UI/UX** - Apple-grade design system
- 📱 **Fully Responsive** - Mobile, tablet, and desktop optimized
- ⚡ **Performance Optimized** - <2s load time, 60fps animations
- 🔐 **Secure** - JWT authentication, RBAC
- ♿ **Accessible** - WCAG 2.1 AA+ compliant
- 🌐 **Multi-company** - Switch between organizations

### 8 Production Pages

1. **Dashboard** - Command center with KPIs and quick actions
2. **Employee Directory** - Search, filter, bulk operations
3. **Salary Builder** - Calculate standard & sales salaries
4. **Offer Letter** - Generate professional offers
5. **Salary Slip** - Monthly statements with bulk generation
6. **Payroll Register** - Process payroll with compliance
7. **Reports & Analytics** - Monthly, annual, tax reports
8. **Admin Settings** - Company, users, policies

---

## 🛠️ Tech Stack

### Core

| Technology | Version | Purpose |
|------------|---------|----------|
| **React** | 18.2.0 | UI library |
| **TypeScript** | 5.3.3 | Type safety |
| **Vite** | 5.0.8 | Build tool |
| **React Router** | 6.20.0 | Routing |

### State & Data

| Library | Version | Purpose |
|---------|---------|----------|
| **Zustand** | 4.4.7 | Global state |
| **Axios** | 1.6.2 | HTTP client |
| **SWR** | 2.2.4 | Data fetching |

### UI & Styling

| Library | Version | Purpose |
|---------|---------|----------|
| **Tailwind CSS** | 3.3.6 | Utility CSS |
| **Framer Motion** | 10.16.16 | Animations |
| **Lucide React** | 0.295.0 | Icons |
| **Recharts** | 2.10.3 | Charts |

---

## 🚀 Quick Start

### Prerequisites

- **Node.js** ≥ 16.0.0
- **npm** ≥ 8.0.0
- **Backend API** running ([Setup Guide](https://github.com/portfoliobuilders/portfolix-compass-backend))

### Installation

```bash
# 1. Clone repository
git clone https://github.com/portfoliobuilders/portfolix-compass-frontend.git
cd portfolix-compass-frontend

# 2. Install dependencies
npm install

# 3. Configure environment
cp .env.example .env.local
# Update VITE_API_BASE_URL with your backend URL

# 4. Start development server
npm run dev
```

The app will be available at `http://localhost:5173`

### Build for Production

```bash
npm run build
npm run preview  # Preview production build
```

---

## 📁 Project Structure

```
src/
├── components/           # Reusable UI components
│   ├── Layout/          # Layout components (Sidebar, Header)
│   └── Common/          # Common UI elements (Button, Card, Modal)
├── pages/               # Page components (8 core pages)
├── services/            # API integration layer
├── store/               # Zustand global state
├── types/               # TypeScript type definitions
├── utils/               # Utility functions & helpers
├── App.tsx              # Main application component
└── main.tsx            # Entry point
```

---

## 💻 Development

### Available Scripts

```bash
npm run dev          # Start development server
npm run build        # Build for production
npm run preview      # Preview production build
npm run lint         # Lint code
npm run format       # Format code with Prettier
npm run type-check   # TypeScript type checking
```

### Code Quality

- **TypeScript** - 100% type coverage, no `any` types
- **ESLint** - Code linting with React best practices
- **Prettier** - Consistent code formatting
- **Git Hooks** - Pre-commit checks (optional)

---

## 🚢 Deployment

### Vercel (Recommended)

```bash
npm install -g vercel
vercel
```

### Docker

```bash
docker build -t portfolix-compass-frontend .
docker run -p 3000:3000 portfolix-compass-frontend
```

### Static Hosting

```bash
npm run build
# Upload dist/ folder to any static host
```

---

## 📚 Documentation

- [API Integration Guide](docs/API_INTEGRATION.md) - Backend integration
- [Component Library](docs/COMPONENTS.md) - Reusable components
- [State Management](docs/STATE.md) - Zustand store usage
- [Deployment Guide](docs/DEPLOYMENT.md) - Production deployment

---

## 🤝 Contributing

This is a proprietary project for Portfolio Builders. Internal team members can contribute by:

1. Creating a feature branch
2. Making changes with proper TypeScript types
3. Running tests and linting
4. Submitting a pull request

---

## 📄 License

Proprietary - © 2025 Portfolio Builders. All rights reserved.

---

## 📞 Support

- **Email**: dev@portfoliobuilders.in
- **Backend Repo**: [portfolix-compass-backend](https://github.com/portfoliobuilders/portfolix-compass-backend)

---

**Built with ❤️ by Portfolio Builders Team**
