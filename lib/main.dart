import 'package:aplikasi_dosen/homepage/home.dart';
import 'package:aplikasi_dosen/login dan register/login.dart';
import 'package:aplikasi_dosen/pesan/controllers/auth_dosen_controller.dart';
import 'package:aplikasi_dosen/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthDosenController()); // ⬅️ tetap penting untuk dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // ⬅️ Ganti dari MaterialApp ke GetMaterialApp
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginTwo()),
        GetPage(name: '/homepage', page: () => const homepage()),
        // Tambahkan GetPage lainnya jika ada navigasi dengan Get.toNamed()
      ],
    );
  }
}
