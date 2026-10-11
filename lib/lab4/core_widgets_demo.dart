import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('01 · Core Widgets')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Welcome to Flutter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        const Icon(Icons.movie_filter, size: 56),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
            height: 220,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              height: 220,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: const Center(
                child: Icon(Icons.flutter_dash_rounded, size: 72),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Card(
          child: ListTile(
            leading: Icon(Icons.school_outlined),
            title: Text('Flutter UI Fundamentals'),
            subtitle: Text('Text · Image · Icon · Card · ListTile'),
            trailing: Icon(Icons.check_circle_outline),
          ),
        ),
      ],
    ),
  );
}
