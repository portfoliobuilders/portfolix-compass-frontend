import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(getAnalyticsSummaryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: analyticsAsync.when(
        data: (data) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildMetricCard('Total Revenue', '\$500K', Colors.green),
            const SizedBox(height: 12),
            _buildMetricCard('Growth Rate', '+15%', Colors.blue),
            const SizedBox(height: 12),
            _buildMetricCard('Active Users', '120', Colors.purple),
            const SizedBox(height: 24),
            Text('Trends', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Card(
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text('Chart Placeholder', style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(colors: [color.withOpacity(0.1), color.withOpacity(0.05)]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 8),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            Icon(Icons.trending_up, color: color, size: 32),
          ],
        ),
      ),
    );
  }
}
