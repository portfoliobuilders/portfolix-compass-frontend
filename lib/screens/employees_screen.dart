import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class EmployeesScreen extends ConsumerWidget {
  const EmployeesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesAsync = ref.watch(getEmployeesProvider((1, 20)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      ),
      body: employeesAsync.when(
        data: (employees) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search employees',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: employees.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text('Employee ${index + 1}'),
                subtitle: const Text('Department'),
                trailing: const Icon(Icons.arrow_forward_ios),
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
