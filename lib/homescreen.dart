// import 'package:aplikasi_dosen/akun/infoakun.dart';
// import 'package:aplikasi_dosen/homepage/home.dart';
// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:aplikasi_dosen/pesan/pesan.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   _HomepageState createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   int _selectedIndex = 1; // Indeks awal (Home)

//   // List halaman berdasarkan indeks
//   final List<Widget> _pages = [
//     const Pesan(), // Index 0 -> Halaman Pesan
//     const Homepage(), // Index 1 -> Halaman Utama
//     const infoakun()
//     //  // Index const ProfileScreen(),2 -> Halaman Profil
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex], // Menampilkan halaman sesuai indeks
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.transparent,
//         height: 70,
//         color: const Color(0xFF00712D),
//         index: _selectedIndex, // Set indeks awal
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index; // Ubah halaman saat item ditekan
//           });
//         },
//         items: const [
//           Icon(Icons.message_sharp, size: 30, color: Colors.white), // Pesan
//           Icon(Icons.home, size: 30, color: Colors.white), // Home
//           Icon(Icons.account_circle_sharp,
//               size: 30, color: Colors.white), // Profil
//         ],
//       ),
//     );
//   }
// }
