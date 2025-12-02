// ═══════════════════════════════════════════════════════════════════════════
// 🔧 PORTFOLIX COMPASS - SALARY CALCULATION ENGINE
// ═══════════════════════════════════════════════════════════════════════════

import {
  StandardSalaryResult,
  SalesSalaryResult,
  SalesCommissionTier,
} from '../types';

// Professional Tax Slabs (Kerala)
const PT_SLABS = [
  { max: 10000, rate: 0 },
  { max: 15000, rate: 100 },
  { max: 20000, rate: 150 },
  { max: 25000, rate: 200 },
  { max: 30000, rate: 250 },
  { max: Infinity, rate: 300 },
];

// Commission Tiers (Sales)
const COMMISSION_TIERS = [
  { max: 12, rate: 1000 },
  { max: 20, rate: 2500 },
  { max: 30, rate: 3500 },
  { max: 40, rate: 4500 },
  { max: 50, rate: 5500 },
  { max: 1000, rate: 6500 },
];

// Sales Base Salary by Career Stage
const SALES_BASE = {
  probation: 5000,
  established: 13000,
};

// Sales Fixed Allowances
const SALES_ALLOWANCES = {
  skill: 1500,
  medical: 1250,
  wellness: 2500,
};

export const calculatePT = (grossEarnings: number): number => {
  const slab = PT_SLABS.find((s) => grossEarnings <= s.max);
  return slab ? slab.rate : 300;
};

export const calculateStandardSalary = (
  basicSalary: number,
  specialAllowance: number = 0,
  otherAllowance: number = 0,
  incomeTax: number = 0,
  otherDeductions: number = 0
): StandardSalaryResult => {
  const hra = Math.round((basicSalary * 0.3 * 100) / 100);
  const da = Math.round((basicSalary * 0.08 * 100) / 100);
  const gross = basicSalary + hra + da + specialAllowance + otherAllowance;

  const pf = Math.round(((basicSalary + da) * 0.12 * 100) / 100);
  const pt = calculatePT(gross);

  const totalDeductions = pf + pt + incomeTax + otherDeductions;

  return {
    type: 'standard',
    earnings: {
      basicSalary,
      hra,
      da,
      specialAllowance,
      otherAllowance,
      gross,
    },
    deductions: {
      pf,
      professionalTax: pt,
      incomeTax,
      otherDeductions,
      total: totalDeductions,
    },
    net: gross - totalDeductions,
    annualCTC: gross * 12,
    monthlyLPA: (gross * 12) / 100000,
  };
};

export const calculateCommissionByTiers = (salesCount: number) => {
  let total = 0;
  const breakdown: SalesCommissionTier[] = [];
  let remaining = salesCount;
  let prevMax = 0;
  let tierIndex = 0;

  for (const tier of COMMISSION_TIERS) {
    if (remaining <= 0) break;

    const tierSize = tier.max - prevMax;
    const salesInTier = Math.min(remaining, tierSize);
    const tierCommission = salesInTier * tier.rate;

    breakdown.push({
      tier: tierIndex + 1,
      range: `${prevMax + 1}-${tier.max}`,
      ratePerSale: tier.rate,
      salesCount: salesInTier,
      commission: tierCommission,
    });

    total += tierCommission;
    remaining -= salesInTier;
    prevMax = tier.max;
    tierIndex++;
  }

  return { total, breakdown };
};

export const calculateSalesSalary = (
  careerStage: 'probation' | 'established',
  salesCount: number,
  referralCount: number = 0
): SalesSalaryResult => {
  const baseSalary = SALES_BASE[careerStage];
  const fixedTotal =
    baseSalary + Object.values(SALES_ALLOWANCES).reduce((a, b) => a + b);

  const { total: commission, breakdown } =
    calculateCommissionByTiers(salesCount);

  // Calculate bonuses
  let bonuses = 0;
  if (careerStage === 'probation') {
    if (salesCount >= 4) bonuses += 500;
    if (salesCount >= 8) bonuses += 500;
  } else {
    if (salesCount >= 3) bonuses += 500;
    if (salesCount >= 8) bonuses += 500;
  }

  // Calculate referral bonus (only for established)
  let referralBonus = 0;
  if (careerStage === 'established' && referralCount > 0) {
    const referralRates = [4500, 5500, 7000, 10000];
    let totalReferralBonus = 0;
    for (let i = 0; i < referralCount; i++) {
      const idx = Math.min(i, referralRates.length - 1);
      totalReferralBonus += referralRates[idx];
    }
    // Quarterly average + monthly cap
    referralBonus = Math.min(totalReferralBonus / 3, 30000);
  }

  const gross = fixedTotal + commission + bonuses + referralBonus;
  const deductions = { welfareFund: 150, communication: 400, total: 550 };

  return {
    type: 'sales',
    careerStage,
    fixed: {
      baseSalary,
      skillAllowance: SALES_ALLOWANCES.skill,
      medicalAllowance: SALES_ALLOWANCES.medical,
      wellnessAllowance: SALES_ALLOWANCES.wellness,
      total: fixedTotal,
    },
    variable: {
      salesCount,
      commissionTierBreakdown: breakdown,
      commission,
      bonuses,
      referralCount,
      referralBonus: Math.round(referralBonus * 100) / 100,
      total: commission + bonuses + referralBonus,
    },
    earnings: { gross: Math.round(gross * 100) / 100 },
    deductions,
    net: Math.round((gross - deductions.total) * 100) / 100,
    annualCTC: Math.round((gross * 12 - deductions.total * 12) * 100) / 100,
    monthlyLPA: ((gross - deductions.total) * 12) / 100000,
  };
};

export const formatCurrency = (amount: number): string => {
  return (
    '₹' +
    amount.toLocaleString('en-IN', {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    })
  );
};

export const formatDate = (date: Date | string): string => {
  return new Date(date).toLocaleDateString('en-IN', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });
};

export const formatDateISO = (date: Date | string): string => {
  return new Date(date).toISOString().split('T')[0];
};

export const amountInWords = (amount: number): string => {
  const ones = [
    '',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
  ];
  const teens = [
    'Ten',
    'Eleven',
    'Twelve',
    'Thirteen',
    'Fourteen',
    'Fifteen',
    'Sixteen',
    'Seventeen',
    'Eighteen',
    'Nineteen',
  ];
  const tens = [
    '',
    '',
    'Twenty',
    'Thirty',
    'Forty',
    'Fifty',
    'Sixty',
    'Seventy',
    'Eighty',
    'Ninety',
  ];
  const scales = ['', 'Thousand', 'Lakh', 'Crore'];

  if (amount === 0) return 'Zero';

  let result = '';
  let scaleIndex = 0;

  while (amount > 0 && scaleIndex < scales.length) {
    const chunk = amount % 1000;
    if (chunk !== 0) {
      result =
        convertChunk(chunk, ones, teens, tens) +
        (scales[scaleIndex] ? ' ' + scales[scaleIndex] : '') +
        ' ' +
        result;
    }
    amount = Math.floor(amount / 1000);
    scaleIndex++;
  }

  return result.trim();
};

const convertChunk = (
  num: number,
  ones: string[],
  teens: string[],
  tens: string[]
): string => {
  let result = '';
  const hundreds = Math.floor(num / 100);
  const remainder = num % 100;

  if (hundreds > 0) {
    result += ones[hundreds] + ' Hundred';
  }

  if (remainder >= 10 && remainder < 20) {
    result += (result ? ' ' : '') + teens[remainder - 10];
  } else {
    const ten = Math.floor(remainder / 10);
    const one = remainder % 10;

    if (ten > 0) {
      result += (result ? ' ' : '') + tens[ten];
    }
    if (one > 0) {
      result += (result ? ' ' : '') + ones[one];
    }
  }

  return result;
};
