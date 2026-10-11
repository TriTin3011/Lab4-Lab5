// Import thư viện Flutter Material Design
import 'package:flutter/material.dart';

// CalculatorApp: Widget cha, khai báo đây là màn hình máy tính
// StatefulWidget: có trạng thái (state) thay đổi khi người dùng tương tác
class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  // createState(): bắt buộc với StatefulWidget, tạo ra object State tương ứng
  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

// _CalculatorAppState: class chứa toàn bộ logic và giao diện của Calculator
// (Tên bắt đầu bằng _ nghĩa là private, chỉ dùng trong file này)
class _CalculatorAppState extends State<CalculatorApp> {
  // Controller để đọc/ghi nội dung của ô nhập số thứ nhất
  final TextEditingController firstController = TextEditingController();

  // Controller để đọc/ghi nội dung của ô nhập số thứ hai
  final TextEditingController secondController = TextEditingController();

  // Biến lưu kết quả tính toán (khởi đầu là chuỗi rỗng)
  String result = '';

  // Hàm thực hiện phép tính dựa vào operator được truyền vào ('+', '-', '*', '/')
  void calculate(String operator) {
    // double.tryParse(): chuyển chuỗi thành số thực, trả về null nếu không hợp lệ
    double? number1 = double.tryParse(firstController.text);

    double? number2 = double.tryParse(secondController.text);

    // Kiểm tra: nếu một trong hai ô nhập trống hoặc không phải số → báo lỗi
    if (number1 == null || number2 == null) {
      // setState(): báo cho Flutter biết cần vẽ lại giao diện với giá trị mới
      setState(() {
        result = 'Vui lòng nhập đúng số';
      });

      return; // Dừng hàm, không tính tiếp
    }

    double value; // Biến tạm lưu kết quả phép tính

    // switch-case: kiểm tra phép toán nào được chọn
    switch (operator) {
      case '+':
        value = number1 + number2; // Phép cộng
        break;

      case '-':
        value = number1 - number2; // Phép trừ
        break;

      case '*':
        value = number1 * number2; // Phép nhân
        break;

      case '/':
        // Kiểm tra chia cho 0 (không thể thực hiện)
        if (number2 == 0) {
          setState(() {
            result = 'Không thể chia cho 0';
          });
          return; // Dừng hàm sớm
        }

        value = number1 / number2; // Phép chia
        break;

      default:
        return; // Toán tử không hợp lệ → bỏ qua
    }

    // Cập nhật kết quả lên giao diện
    setState(() {
      result = formatNumber(value);
    });
  }

  // Hàm định dạng số: nếu là số nguyên thì bỏ phần thập phân, ngược lại giữ 2 chữ số
  // Ví dụ: 4.0 → "4"  |  3.14159 → "3.14"
  String formatNumber(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString(); // Trả về số nguyên
    }

    return value.toStringAsFixed(2); // Trả về số thực 2 chữ số thập phân
  }

  // dispose(): được gọi khi widget bị xóa khỏi cây widget
  // Cần giải phóng controller để tránh rò rỉ bộ nhớ (memory leak)
  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    super.dispose(); // Luôn gọi super.dispose() ở cuối
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .scaffoldBackgroundColor, // Nền màu trắng
      // AppBar: thanh tiêu đề
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),

      // Center: căn giữa toàn bộ nội dung
      body: Center(
        // SingleChildScrollView: cho phép cuộn khi nội dung vượt quá màn hình
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          // SizedBox: giới hạn chiều rộng tối đa là 360px
          child: SizedBox(
            width: 360,

            // Column: sắp xếp các widget theo chiều dọc
            child: Column(
              mainAxisSize: MainAxisSize.min, // Chiều cao co lại vừa nội dung

              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B6CFF), Color(0xFF5A3EE8)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.calculate_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Tính toán nhanh',
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Text(
                  'Nhập hai số và chọn phép tính',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 28),
                // ─── Ô NHẬP SỐ THỨ NHẤT ───
                TextField(
                  controller: firstController, // Gắn controller để đọc giá trị
                  // Bàn phím số, có thể nhập số thập phân
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),

                  decoration: InputDecoration(
                    hintText:
                        'Nhập số thứ nhất', // Placeholder hiển thị khi trống

                    filled: true, // Tô màu nền cho ô nhập

                    fillColor: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest, // Màu nền tím nhạt

                    prefixIcon: const Icon(Icons.looks_one_rounded),
                    // Padding bên trong ô nhập
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 22,
                    ),
                  ),
                ),

                const SizedBox(height: 25), // Khoảng cách giữa 2 ô nhập
                // ─── Ô NHẬP SỐ THỨ HAI ───
                TextField(
                  controller: secondController,

                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),

                  decoration: InputDecoration(
                    hintText: 'Nhập số thứ hai',

                    filled: true,

                    fillColor: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,

                    prefixIcon: const Icon(Icons.looks_two_rounded),

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 22,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ─── 4 NÚT PHÉP TÍNH ───
                // Row: sắp xếp các widget theo chiều ngang
                Row(
                  children: [
                    // Gọi hàm buildButton() để tạo nút Cộng
                    buildButton(
                      'Cộng',
                      () => calculate('+'), // Arrow function gọi calculate('+')
                    ),

                    const SizedBox(width: 10),

                    buildButton('Trừ', () => calculate('-')),

                    const SizedBox(width: 10),

                    buildButton('Nhân', () => calculate('*')),

                    const SizedBox(width: 10),

                    buildButton('Chia', () => calculate('/')),
                  ],
                ),

                const SizedBox(height: 30),

                // ─── HIỂN THỊ KẾT QUẢ ───
                // Chỉ hiển thị khung kết quả khi result không rỗng
                if (result.isNotEmpty)
                  Container(
                    width: double.infinity, // Chiều rộng toàn phần

                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      'Kết quả: $result', // String interpolation: chèn biến vào chuỗi

                      textAlign: TextAlign.center, // Căn giữa chữ

                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold, // In đậm
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── HÀM TẠO NÚT (tái sử dụng, tránh viết lặp code) ───
  // Nhận vào: text (nhãn nút) và onPressed (hàm xử lý khi nhấn)
  Widget buildButton(String text, VoidCallback onPressed) {
    // Expanded: giúp nút chiếm đều phần còn lại trong Row
    return Expanded(
      child: SizedBox(
        height: 50,

        child: ElevatedButton(
          onPressed: onPressed, // Hàm được gọi khi nhấn nút
          // Tùy chỉnh style cho nút
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,

            foregroundColor: Colors.white, // Màu chữ trắng

            padding: EdgeInsets.zero, // Bỏ padding mặc định
            // Bo góc nhẹ 3px
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),

          child: Text(text), // Hiển thị nhãn nút
        ),
      ),
    );
  }
}
