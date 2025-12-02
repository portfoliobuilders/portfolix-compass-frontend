# Portfolix Compass Frontend - Development Guide

## ✅ Completed Foundation

### Already Created:
1. **Package Configuration** - package.json, tsconfig.json, vite.config.ts, tailwind.config.js
2. **Type Definitions** - Complete TypeScript types in `src/types/index.ts`
3. **API Client** - Axios setup in `src/services/api.ts` with interceptors
4. **State Management** - Zustand store in `src/store/useStore.ts`
5. **Calculations Engine** - Salary & tax calculations in `src/utils/calculations.ts`
6. **Entry Point** - `src/main.tsx` with React 18 setup
7. **Global Styles** - `src/index.css` with Tailwind + custom animations
8. **Routing** - `src/App.tsx` with React Router protected routes
9. **Layouts** - `src/layouts/MainLayout.tsx` and `src/layouts/AuthLayout.tsx`

## 📋 Remaining Components To Create

### STEP 1: Create Common UI Components (src/components/)

#### Essential Components Needed:
1. **Button.tsx** - Reusable button with variants
2. **Input.tsx** - Text input with validation
3. **Card.tsx** - Container component
4. **Modal.tsx** - Dialog component
5. **Table.tsx** - Data table
6. **Select.tsx** - Dropdown select
7. **Checkbox.tsx** - Checkbox input
8. **Badge.tsx** - Status badge
9. **Alert.tsx** - Alert messages
10. **LoadingSpinner.tsx** - Loading indicator
11. **Header.tsx** - Top navigation bar
12. **Sidebar.tsx** - Left navigation sidebar
13. **Breadcrumb.tsx** - Navigation breadcrumb
14. **Pagination.tsx** - Pagination control
15. **Form.tsx** - Form wrapper
16. **Textarea.tsx** - Text area input
17. **Toast.tsx** - Toast notifications
18. **Tooltip.tsx** - Tooltip component
19. **DatePicker.tsx** - Date picker input
20. **NumberInput.tsx** - Number input with formatting

### STEP 2: Create Authentication Pages (src/pages/auth/)

1. **Login.tsx** - Login form with email/password
2. **Register.tsx** - Registration form
3. **ForgotPassword.tsx** (Optional) - Password reset

### STEP 3: Create Core Pages (src/pages/)

1. **Dashboard.tsx**
   - Key Metrics: Total Employees, Avg Salary, Pending Approvals
   - Charts: Salary Distribution, Employee Growth
   - Quick Actions: Add Employee, Generate Salary Slip

2. **EmployeeManagement.tsx**
   - Employee list with pagination
   - Search & filter functionality
   - Add/Edit/Delete employee
   - Bulk import from CSV

3. **EmployeeDetail.tsx**
   - Individual employee profile
   - Salary history
   - Documents
   - Leave management

4. **SalaryBuilder.tsx**
   - Salary structure builder
   - Configure standard salary tiers
   - Sales commission structure (6-tier system)
   - Special allowances
   - Deductions management

5. **OfferLetter.tsx**
   - Generate offer letters
   - PDF download
   - Template management
   - Email sending

6. **SalarySlip.tsx**
   - View/Generate salary slips
   - Download as PDF
   - Email to employees
   - Bulk generation

7. **PayrollRegister.tsx**
   - Payroll summary
   - Pending approvals
   - Process payroll
   - View payroll history
   - Export to accounting software

8. **Reports.tsx**
   - Salary analysis reports
   - Tax compliance reports
   - Attendance reports
   - Custom report builder

9. **AdminSettings.tsx**
   - Company configuration
   - Fiscal year settings
   - Tax settings (PT, Income Tax)
   - User management
   - Audit logs

## 🛠️ Implementation Steps

### Phase 1: Create UI Components Library

Start with creating reusable components with proper TypeScript types and Tailwind styling.

```bash
# Create components folder structure
src/components/
  ├── ui/
  │   ├── Button.tsx
  │   ├── Input.tsx
  │   ├── Card.tsx
  │   ├── Modal.tsx
  │   ├── Table.tsx
  │   ├── Select.tsx
  │   ├── Checkbox.tsx
  │   ├── Badge.tsx
  │   ├── Alert.tsx
  │   └── LoadingSpinner.tsx
  ├── Layout/
  │   ├── Header.tsx
  │   ├── Sidebar.tsx
  │   └── Breadcrumb.tsx
  ├── Form/
  │   ├── Form.tsx
  │   ├── Textarea.tsx
  │   ├── DatePicker.tsx
  │   └── NumberInput.tsx
  └── Feedback/
      ├── Toast.tsx
      ├── Tooltip.tsx
      └── Pagination.tsx
```

### Phase 2: Create Auth Pages

Implement authentication flows with form validation and error handling.

### Phase 3: Create Dashboard & Core Pages

Build main application features with proper data fetching and state management.

### Phase 4: Integration & Testing

Integrate all components, test with backend API, and optimize performance.

## 🎨 Design System

### Color Palette
- Primary Teal: `#0d9488`
- Success Green: `#10b981`
- Warning Orange: `#f59e0b`
- Error Red: `#ef4444`
- Gray Scale: Gray 50-900

### Typography
- Heading 1: 2.25rem (36px)
- Heading 2: 1.875rem (30px)
- Heading 3: 1.5rem (24px)
- Body: 1rem (16px)
- Small: 0.875rem (14px)

### Spacing
- Use Tailwind's default spacing: 4px, 8px, 12px, 16px, 24px, 32px, etc.

### Responsive Breakpoints
- Mobile: < 640px
- Tablet: 640px - 1024px
- Desktop: > 1024px

## 📦 Dependencies Already Installed

```json
{
  "react": "^18.2.0",
  "react-router-dom": "^6.20.0",
  "zustand": "^4.4.0",
  "framer-motion": "^10.16.0",
  "axios": "^1.6.0",
  "typescript": "^5.3.0",
  "tailwindcss": "^3.4.0"
}
```

## 🚀 Quick Start

```bash
# Install dependencies
npm install

# Setup environment
cp .env.example .env.local
# Update VITE_API_BASE_URL in .env.local

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

## 🔗 Backend API Integration

The frontend is designed to work with the Portfolix Compass Backend API.
Backend Repository: https://github.com/portfoliobuilders/portfolix-compass-backend

### Key API Endpoints:
- `POST /auth/login` - User login
- `POST /auth/register` - User registration
- `GET /employees` - List employees
- `POST /employees` - Create employee
- `GET /salary-builder` - Get salary structures
- `POST /salary/calculate` - Calculate salary
- `POST /salary-slip/generate` - Generate salary slip
- `GET /payroll` - Payroll data
- `POST /offer-letter/generate` - Generate offer letter

## ✨ Features to Implement

### Must Have (MVP)
- ✅ Authentication (Login/Register)
- ✅ Employee Management (CRUD)
- ✅ Salary Builder
- ✅ Salary Slip Generation
- ✅ Offer Letter Generation
- ✅ Basic Dashboard
- ✅ Payroll Register

### Nice to Have
- Reports & Analytics
- Bulk Employee Import
- Email Integration
- PDF Generation
- Approval Workflow
- Audit Logging

## 📝 Code Quality

- Use TypeScript strict mode
- PropTypes for all components
- Error boundaries for error handling
- Loading states for all async operations
- Proper form validation
- Accessibility (WCAG 2.1)
- Mobile responsive design
- Performance optimization (code splitting, lazy loading)

## 🐛 Testing Strategy

- Unit tests for utils and calculations
- Component tests for UI components
- Integration tests for pages
- E2E tests for critical user flows

## 📚 Resources

- React: https://react.dev
- TypeScript: https://www.typescriptlang.org
- Tailwind CSS: https://tailwindcss.com
- Zustand: https://github.com/pmndrs/zustand
- Framer Motion: https://www.framer.com/motion

## 🎯 Development Priority

1. **Week 1**: Create UI component library
2. **Week 2**: Build auth pages and dashboard
3. **Week 3**: Implement employee management
4. **Week 4**: Build salary builder and slip generator
5. **Week 5**: Integrate with backend API
6. **Week 6**: Testing and bug fixes
7. **Week 7**: Performance optimization
8. **Week 8**: Deployment and documentation

## 📞 Support

For questions or issues, contact the Portfolio Builders development team.
