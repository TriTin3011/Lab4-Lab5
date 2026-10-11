// Import thư viện dart:math để dùng class Random (sinh số ngẫu nhiên)
import 'dart:math';

// Import thư viện Flutter Material Design
import 'package:flutter/material.dart';

// RandomNumberApp: Widget cha khai báo màn hình tạo số ngẫu nhiên
// StatefulWidget vì màn hình cần cập nhật giao diện khi bấm Generate
class RandomNumberApp extends StatefulWidget {
  const RandomNumberApp({super.key});

  // Tạo object State tương ứng để quản lý trạng thái
  @override
  State<RandomNumberApp> createState() => _RandomNumberAppState();
}

// _RandomNumberAppState: chứa toàn bộ logic và giao diện
class _RandomNumberAppState extends State<RandomNumberApp> {
  // Controller cho ô Min, mặc định giá trị là '1'
  final TextEditingController minController = TextEditingController(text: '1');

  // Controller cho ô Max, mặc định giá trị là '100'
  final TextEditingController maxController = TextEditingController(
    text: '100',
  );

  // Biến lưu kết quả sinh ngẫu nhiên (null = chưa sinh lần nào)
  int? result;

  // Hàm sinh số ngẫu nhiên trong khoảng [min, max]
  void generateRandomNumber() {
    // int.tryParse(): chuyển chuỗi thành số nguyên, null nếu không hợp lệ
    int? min = int.tryParse(minController.text);
    int? max = int.tryParse(maxController.text);

    // Kiểm tra: min hoặc max không hợp lệ, hoặc min > max → báo lỗi
    if (min == null || max == null || min > max) {
      setState(() {
        result = null; // Xóa kết quả cũ
      });

      // Hiển thị thanh thông báo lỗi ở dưới màn hình (SnackBar)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid Min and Max values')),
      );

      return; // Dừng hàm, không sinh số
    }

    // Tạo đối tượng Random để sinh số ngẫu nhiên
    final random = Random();

    setState(() {
      // Công thức: min + random.nextInt(max - min + 1)
      // nextInt(n) trả về số ngẫu nhiên trong [0, n-1]
      // → cộng min để dịch về khoảng [min, max]
      result = min + random.nextInt(max - min + 1);
    });
  }

  // Giải phóng bộ nhớ khi widget bị hủy
  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Nền trắng
      // AppBar: thanh tiêu đề
      appBar: AppBar(
        title: const Text(
          'Random Number',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),

      // Center: căn giữa toàn bộ nội dung
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          // Container: hộp có viền bao quanh toàn bộ widget
          child: Container(
            width: 360,
            // BoxDecoration: trang trí cho Container
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),

            // Column: sắp xếp các widget theo chiều dọc
            child: Column(
              mainAxisSize: MainAxisSize.min, // Chiều cao vừa khít nội dung

              children: [
                // ─── PHẦN HEADER (tiêu đề phía trên) ───
                Container(
                  width: double.infinity, // Chiều rộng toàn phần
                  padding: const EdgeInsets.symmetric(vertical: 28),

                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF7C5CFC), Color(0xFF5135D3)],
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(27),
                    ),
                  ),

                  child: const Text(
                    'Random Number\nGenerator',
                    textAlign: TextAlign.center, // Căn giữa

                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                // ─── PHẦN NỘI DUNG ───
                Padding(
                  padding: const EdgeInsets.all(22),

                  child: Column(
                    children: [
                      // ─── HÀNG NHẬP MIN ───
                      Row(
                        children: [
                          // Nhãn "Min:" với chiều rộng cố định 55px
                          const SizedBox(
                            width: 55,

                            child: Text('Min:', style: TextStyle(fontSize: 18)),
                          ),

                          // Ô nhập liệu Min chiếm phần còn lại của Row
                          Expanded(
                            child: SizedBox(
                              height: 45, // Chiều cao cố định

                              child: TextField(
                                controller: minController,
                                keyboardType: TextInputType
                                    .number, // Chỉ hiện bàn phím số

                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),

                                  border: OutlineInputBorder(), // Viền xung quanh ô nhập
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10), // Khoảng cách giữa 2 hàng
                      // ─── HÀNG NHẬP MAX ───
                      Row(
                        children: [
                          // Nhãn "Max:"
                          const SizedBox(
                            width: 55,

                            child: Text('Max:', style: TextStyle(fontSize: 18)),
                          ),

                          // Ô nhập liệu Max
                          Expanded(
                            child: SizedBox(
                              height: 45,

                              child: TextField(
                                controller: maxController,
                                keyboardType: TextInputType.number,

                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),

                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // ─── NÚT GENERATE ───
                      // Align: căn chỉnh widget con về phía trái
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          // Khi nhấn → gọi hàm generateRandomNumber()
                          onPressed: generateRandomNumber,

                          icon: const Icon(Icons.auto_awesome_rounded),
                          label: const Text(
                            'Tạo số ngẫu nhiên',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // ─── HIỂN THỊ KẾT QUẢ ───
                      // Align: căn kết quả về phía trái
                      Align(
                        alignment: Alignment.centerLeft,

                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            // Toán tử 3 ngôi: nếu result là null thì hiện "Result:",
                            // ngược lại hiện "Result: <số>"
                            result == null ? 'Result:' : 'Result: $result',

                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
