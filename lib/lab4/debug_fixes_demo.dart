import 'package:flutter/material.dart';

class DebugFixesDemo extends StatefulWidget {
  const DebugFixesDemo({super.key});
  @override
  State<DebugFixesDemo> createState() => _DebugFixesDemoState();
}

class _DebugFixesDemoState extends State<DebugFixesDemo> {
  int _count = 0;
  DateTime? _date;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('05 · Debug & Fix')),
    // Sửa overflow: toàn trang cuộn khi màn hình nhỏ hoặc bàn phím mở.
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '1. ListView bên trong Column',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'Dùng Expanded để ListView nhận chiều cao còn lại trong vùng có giới hạn.',
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: Column(
              children: [
                const Text('Danh sách có thể cuộn riêng'),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (_, i) =>
                        ListTile(title: Text('Item ${i + 1}')),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '2. Overflow trên màn hình nhỏ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'SingleChildScrollView bọc nội dung; tránh ép chiều cao tổng của Column.',
          ),
          const SizedBox(height: 24),
          const Text(
            '3. Cập nhật state',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Bộ đếm: $_count'),
          FilledButton(
            onPressed: () => setState(() => _count++),
            child: const Text('Tăng bộ đếm'),
          ),
          const SizedBox(height: 24),
          const Text(
            '4. DatePicker context',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'Mở picker từ callback trong cây MaterialApp; kiểm tra mounted sau await.',
          ),
          OutlinedButton.icon(
            onPressed: () async {
              final value = await showDatePicker(
                context: context,
                initialDate: _date ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (!mounted || value == null) return;
              setState(() => _date = value);
            },
            icon: const Icon(Icons.calendar_month),
            label: const Text('Mở DatePicker'),
          ),
          Text(
            _date == null
                ? 'Chưa chọn ngày'
                : '${_date!.day}/${_date!.month}/${_date!.year}',
          ),
        ],
      ),
    ),
  );
}
