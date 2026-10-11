class LabDemoItem {
  const LabDemoItem(this.title, this.subtitle, this.iconCode);

  final String title;
  final String subtitle;
  final int iconCode;
}

const labDemoItems = [
  LabDemoItem('Widget cơ bản', 'Text, Image, Icon và Card', 0xe1bd),
  LabDemoItem(
    'Điều khiển nhập liệu',
    'Slider, Switch, Radio và DatePicker',
    0xe429,
  ),
  LabDemoItem('Bố cục responsive', 'Row, Column, Padding và ListView', 0xe871),
  LabDemoItem('Theme hệ thống', 'Light mode và Dark mode', 0xe40a),
  LabDemoItem('Trạng thái giao diện', 'Cập nhật UI bằng setState', 0xe1b1),
];
