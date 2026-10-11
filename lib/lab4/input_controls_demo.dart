import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});
  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _volume = 40;
  bool _notifications = true;
  String _genre = 'Adventure';
  DateTime? _date;

  Future<void> _pickDate() async {
    // Context nằm dưới MaterialApp, cung cấp localization cho picker.
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (!mounted || picked == null) return;
    setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('02 · Input Controls')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Tùy chỉnh trải nghiệm',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text('Âm lượng: ${_volume.round()}%'),
        Slider(
          value: _volume,
          min: 0,
          max: 100,
          divisions: 20,
          label: '${_volume.round()}%',
          onChanged: (v) => setState(() => _volume = v),
        ),
        SwitchListTile(
          title: const Text('Thông báo'),
          subtitle: Text(_notifications ? 'Đang bật' : 'Đang tắt'),
          value: _notifications,
          onChanged: (v) => setState(() => _notifications = v),
        ),
        const Divider(height: 32),
        Text('Thể loại: $_genre'),
        RadioGroup<String>(
          groupValue: _genre,
          onChanged: (v) {
            if (v != null) setState(() => _genre = v);
          },
          child: Column(
            children: [
              for (final genre in ['Adventure', 'Drama', 'Animation'])
                RadioListTile<String>(title: Text(genre), value: genre),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _pickDate,
          icon: const Icon(Icons.calendar_month),
          label: const Text('Chọn ngày'),
        ),
        const SizedBox(height: 12),
        Text(
          _date == null
              ? 'Chưa chọn ngày'
              : 'Ngày đã chọn: ${_date!.day}/${_date!.month}/${_date!.year}',
        ),
      ],
    ),
  );
}
