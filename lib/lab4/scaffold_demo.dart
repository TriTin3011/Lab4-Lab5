import 'package:flutter/material.dart';

class ScaffoldDemo extends StatefulWidget {
  const ScaffoldDemo({super.key, required this.onThemeChanged});
  final ValueChanged<bool> onThemeChanged;
  @override
  State<ScaffoldDemo> createState() => _ScaffoldDemoState();
}

class _ScaffoldDemoState extends State<ScaffoldDemo> {
  int _count = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('04 · Scaffold & Theme')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Một màn hình hoàn chỉnh',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        const Text(
          'AppBar, Body và FloatingActionButton cùng dùng ThemeData của ứng dụng.',
        ),
        SwitchListTile(
          title: const Text('Dark Mode'),
          value: Theme.of(context).brightness == Brightness.dark,
          onChanged: widget.onThemeChanged,
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.touch_app_outlined, size: 48),
                const SizedBox(height: 12),
                Text(
                  'Đã nhấn FAB: $_count',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    // setState cập nhật số đếm và yêu cầu Flutter dựng lại UI.
    floatingActionButton: FloatingActionButton(
      onPressed: () => setState(() => _count++),
      child: const Icon(Icons.add),
    ),
  );
}
