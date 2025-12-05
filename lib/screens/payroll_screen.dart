import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

/// Payroll Screen - Manage payroll runs and payslips
class PayrollScreen extends ConsumerWidget {
  const PayrollScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payslipsAsync = ref.watch(getPayslipsProvider((1, 10)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payroll Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
            tooltip: 'New Payroll Run',
          ),
        ],
      ),
      body: payslipsAsync.when(
        data: (payslips) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildPayrollSummary(context),
            const SizedBox(height: 24),
            _buildPayslipsList(context, payslips),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading payslips: $error'),
        ),
      ),
    );
  }

  Widget _buildPayrollSummary(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Payroll Cycle',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SummaryItem('Total', '\$250,000'),
                _SummaryItem('Employees', '120'),
                _SummaryItem('Status', 'Processed'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayslipsList(BuildContext context, List payslips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Payslips',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: payslips.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(Icons.receipt),
              title: Text('Payslip #${index + 1}'),
              subtitle: Text('Dec 2025 - \$5,000'),
              trailing: const Icon(Icons.download),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
