
import 'package:aplikasi_dosen/login%20dan%20register/login.dart';
import 'package:aplikasi_dosen/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserModel(
            name: "Rizki Aulia Nanda",
            nim: "230180222",
            fakultas: "TEKNIK",
            prodi: "Sistem Informasi",
            tempatLahir: "Saturnus",
            tanggalLahir: "12 Desember 2023",
            alamat: "Lhokseumawe",
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginTwo(),
    );
  }
}
