# 🎯 PORTFOLIX COMPASS FRONTEND - COMPLETE IMPLEMENTATION GUIDE
## Apple-Grade HR Onboarding & Salary Compensation Management System

This guide provides step-by-step instructions to complete the frontend, properly syncing with the backend API and implementing Apple-level UI/UX.

---

## 📋 PROJECT OVERVIEW

**Purpose**: HR Onboarding & Employee Salary Compensation Management

**Core Features**:
- Employee lifecycle management (hiring → onboarding → compensation)
- Salary structure calculation (Standard & Sales models)
- Offer letter generation (Professional PDF)
- Salary slip generation (with compliance)
- Payroll processing & register management
- Reports & analytics (monthly, annual, tax, compliance)
- AI/ML-powered insights (predictions, anomaly detection, benchmarking)

**Tech Stack**:
- Frontend: React 18.2 + TypeScript 5.3 + Vite 5.0
- UI: Tailwind CSS 3.3 + Framer Motion
- State: Zustand 4.4 + SWR 2.2
- API Client: Axios 1.6
- Backend: Node.js + Express + MongoDB

---

## 🚀 QUICK START

### Prerequisites
```bash
Node.js >= 16.0
npm >= 8.0
Backend running on http://localhost:5000
```

### Installation
```bash
git clone https://github.com/portfoliobuilders/portfolix-compass-frontend.git
cd portfolix-compass-frontend
npm install
cp .env.example .env.local
```

### Environment Configuration
```bash
# .env.local (Development)
VITE_API_BASE_URL=http://localhost:5000/api
VITE_APP_NAME=Portfolix Compass
VITE_JWT_SECRET=your-secret-key
```

### Run Development Server
```bash
npm run dev
# App available at http://localhost:5173
```

---

## 📂 PROJECT STRUCTURE

```
src/
├── components/          # 20+ reusable UI components
│   ├── Button/
│   ├── Input/
│   ├── Table/
│   ├── Modal/
│   ├── Card/
│   ├── Layout/
│   └── ErrorBoundary/
│
├── pages/              # 8 production pages
│   ├── auth/
│   │   ├── Login.tsx
│   │   └── Register.tsx
│   ├── Dashboard.tsx
│   ├── EmployeeManagement.tsx
│   ├── EmployeeDetail.tsx
│   ├── SalaryBuilder.tsx
│   ├── OfferLetter.tsx
│   ├── SalarySlip.tsx
│   ├── PayrollRegister.tsx
│   ├── Reports.tsx
│   └── AdminSettings.tsx
│
├── services/           # API client & utilities
│   ├── apiClient.ts    # Axios + interceptors
│   ├── endpoints.ts    # Typed API methods
│   └── auth.ts         # JWT handling
│
├── store/              # Global state management
│   ├── authStore.ts    # Auth state (Zustand)
│   ├── uiStore.ts      # UI state
│   └── hooks/          # Custom SWR hooks
│
├── types/              # TypeScript definitions
│   ├── employee.ts
│   ├── salary.ts
│   ├── payroll.ts
│   └── api.ts
│
├── styles/             # Design tokens & globals
│   ├── designTokens.ts # Apple-grade design system
│   ├── globals.css
│   └── tailwind.config.ts
│
├── utils/              # Helper functions
│   ├── formatters.ts   # Currency, dates, etc.
│   ├── validators.ts   # Form validation
│   └── calculations.ts # Salary math
│
├── layouts/            # Layout components
│   ├── MainLayout.tsx
│   └── AuthLayout.tsx
│
├── App.tsx             # Main app with routing
├── main.tsx            # Vite entry point
└── index.html
```

---

## 🎨 DESIGN SYSTEM (Apple-Grade)

### Colors (Your Brand + Apple Palette)
- Primary: #FF6B5B (Your brand coral red)
- Success: #34C759 (Apple green)
- Warning: #FF9500 (Apple orange)
- Error: #FF3B30 (Apple red)
- Neutral: Grays from #000000 to #FFFFFF

### Typography
- Display: 32px, 700 weight (page titles)
- Heading: 24px, 600 weight (section titles)
- Body: 14px, 400 weight (content)
- Caption: 12px, 400 weight (helpers)

### Spacing (4px grid)
- 4px, 8px, 12px, 16px, 20px, 24px, 32px, 40px, 48px, 64px

### Shadows (iOS-style)
- xs: 0 2px 4px rgba(0,0,0,0.08)
- md: 0 4px 12px rgba(0,0,0,0.1)
- lg: 0 8px 24px rgba(0,0,0,0.12)

---

## 🔄 BACKEND INTEGRATION

### API Endpoints Summary (from Backend Reference)
1. **Employees**: CRUD operations for employee data
2. **Salary**: Calculate salaries (standard & sales), AI predictions
3. **Documents**: Generate offer letters & salary slips (PDF)
4. **Payroll**: Register, process, detect anomalies
5. **Compensation**: Parity analysis, market benchmarking
6. **Tax**: Optimization strategies (Kerala-specific)
7. **Compliance**: Check compliance requirements
8. **Reports**: Monthly, annual, tax, compliance reports
9. **Employee**: Insights & performance recommendations
10. **Analytics**: Bulk payroll analysis
11. **Health**: Service health check

### API Client Pattern
```typescript
import { apiClient } from '@/services/apiClient';

// List employees
const { data, error, isLoading } = await apiClient.employees.list({
  department: 'Engineering',
  search: 'John'
});

// Calculate salary
const result = await apiClient.salary.calculate({
  structureType: 'standard',
  basicSalary: 50000
});

// Generate salary slip
const { pdfUrl } = await apiClient.documents.salarySlip({...});
```

---

## 8️⃣ PAGE IMPLEMENTATION

### Page 1: Dashboard
- KPI cards: Total employees, monthly cost, payroll status
- Recent activity timeline
- Quick action buttons
- Department-wise breakdown chart
- Compliance alerts

### Page 2: Employee Management
- Table: Name, ID, Dept, Designation, Salary, Status
- Filters: Department, Designation, Salary range
- Bulk operations: Export CSV, Bulk edit, Delete
- Create/Edit employee modal
- Search functionality

### Page 3: Salary Builder
- Dual structure selector (Standard / Sales)
- Employee form fields
- Real-time CTC calculation
- Earnings/Deductions breakdown
- Next button → Offer Letter

### Page 4: Offer Letter Generator
- 3-step wizard
- Auto-populate from Salary Builder
- PDF preview
- Download/Email options

### Page 5: Salary Slip Generation
- Filter: Month, Department, Employee
- Bulk generation with progress
- Download/Email individual or batch ZIP
- Compliance section

### Page 6: Payroll Register
- Spreadsheet-like table (100+ rows)
- Inline editing
- Bulk upload (CSV)
- Final approval workflow
- Generate reports

### Page 7: Reports & Analytics
- Tabs: Monthly, Annual, Tax, Compliance
- Charts & visualizations
- Export to PDF/Excel
- Custom date range

### Page 8: Admin Settings
- Company profile
- User management
- Salary structure templates
- Approval workflows
- System logs
- API integrations

---

## 🔐 AUTHENTICATION

### Login Flow
1. User enters email/password
2. Backend validates, returns JWT token
3. Token stored in localStorage
4. Auto-included in all API requests
5. Redirect to Dashboard

### JWT Refresh
- Check token expiry on app load
- Refresh if needed
- Redirect to login if invalid

---

## 📊 STATE MANAGEMENT

### Zustand Stores
```typescript
// auth store
useAuthStore: { user, isAuthenticated, login, logout, fetchUser }
uiStore: { sidebarOpen, theme, notifications }
```

### SWR Hooks
```typescript
const { data: employees, error, isLoading, mutate } = useEmployees();
const { data: salary } = useSalaryCalculation(input);
```

---

## ✅ COMPLETION CHECKLIST

### Phase 1: Setup (1 hour)
- [ ] Design system tokens configured
- [ ] Tailwind CSS set up
- [ ] Project structure created
- [ ] .env files configured

### Phase 2: API Client (1 hour)
- [ ] Axios client with interceptors
- [ ] All 12 endpoints implemented
- [ ] Error handling
- [ ] TypeScript types

### Phase 3: Components (2 hours)
- [ ] 20+ components created
- [ ] Storybook stories (optional)
- [ ] Accessibility tested
- [ ] Responsive design

### Phase 4: Pages (2 hours)
- [ ] All 8 pages created
- [ ] Backend data fetching
- [ ] Forms & validations
- [ ] Loading & error states

### Phase 5: Testing (1 hour)
- [ ] npm run build (0 errors)
- [ ] tsc --noEmit (0 errors)
- [ ] All routes work (no 404s)
- [ ] API connectivity verified

### Phase 6: Deployment (1 hour)
- [ ] Production build created
- [ ] Environment variables set
- [ ] Uploaded to Hostinger
- [ ] Production URL verified

---

## 🚨 COMMON ISSUES & SOLUTIONS

**Issue**: 401 errors on API calls
- **Solution**: Check JWT token in localStorage, ensure backend returns valid token

**Issue**: CORS errors
- **Solution**: Configure backend CORS headers, ensure API_BASE_URL is correct

**Issue**: Build errors
- **Solution**: Run `npm install`, check for TypeScript errors with `tsc --noEmit`

**Issue**: Data not loading
- **Solution**: Check network tab, verify backend is running, check API response format

---

## 📱 RESPONSIVE DESIGN

- Desktop (1920px+): Full layout
- Tablet (768px-1024px): Collapsed sidebar, adjusted tables
- Mobile (320px-767px): Stack layout, mobile navigation

---

## 🎯 SUCCESS CRITERIA

✅ All 8 pages load without errors
✅ API calls return data within 500ms
✅ Forms submit successfully
✅ PDF generation works
✅ No console errors
✅ TypeScript strict mode passes
✅ Lighthouse score > 85
✅ Mobile responsive
✅ Keyboard accessible
✅ Production build < 500KB gzipped

---

## 📞 SUPPORT

Backend Repo: https://github.com/portfoliobuilders/portfolix-compass-backend
Frontend Repo: https://github.com/portfoliobuilders/portfolix-compass-frontend
Email: dev@portfoliobuilders.in

Built with ❤️ by Portfolio Builders Team
December 2, 2025
