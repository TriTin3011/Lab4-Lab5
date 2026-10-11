import 'package:flutter/material.dart';

import 'lab4_sample_data.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('03 · Layout Basics')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.local_movies_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Phim nổi bật',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Column chia các phần; Row sắp xếp nội dung ngang.'),
          ),
          const SizedBox(height: 16),
          // Expanded cấp chiều cao hữu hạn cho ListView trong Column.
          Expanded(
            child: ListView.builder(
              itemCount: 18,
              itemBuilder: (context, index) {
                final item = labDemoItems[index % labDemoItems.length];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(item.title),
                      subtitle: Text(item.subtitle),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
