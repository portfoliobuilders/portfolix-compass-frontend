import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Company Settings', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Company Name'),
                  subtitle: const Text('Acme Corporation'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Tax ID'),
                  subtitle: const Text('12-3456789'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Currency'),
                  subtitle: const Text('USD'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('App Settings', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: false,
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  title: const Text('Notifications'),
                  value: true,
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
