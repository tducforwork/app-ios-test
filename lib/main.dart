import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String quote = "Bấm nút bên dưới để gọi API...";

  // Hàm gọi API lấy câu nói ngẫu nhiên
  // Hàm gọi API mới lấy thông tin ngẫu nhiên
  Future<void> fetchQuote() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.ipify.org?format=json'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          // api.ipify.org trả về json có key là 'ip'
          quote = "IP Máy Tính Của Bạn Là:\n${data['ip']}";
        });
      } else {
        setState(() {
          quote = "Server báo lỗi: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        quote = "Không kết nối được API! Lỗi: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Call API Đơn Giảnssss')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quote,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: fetchQuote, // Bấm nút thì chạy hàm fetchQuote
                child: const Text('Gọi API nay bây giờ!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
