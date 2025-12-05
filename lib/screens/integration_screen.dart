import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class IntegrationScreen extends ConsumerWidget {
  const IntegrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final integrationsAsync = ref.watch(getIntegrationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrations'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      ),
      body: integrationsAsync.when(
        data: (integrations) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Connected Services', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: integrations.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.cloud),
                title: Text('Integration ${index + 1}'),
                subtitle: const Text('Connected'),
                trailing: Switch(value: true, onChanged: (_) {}),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
