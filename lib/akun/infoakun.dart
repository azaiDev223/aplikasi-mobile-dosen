import 'package:aplikasi_dosen/akun/datadiri.dart';
import 'package:aplikasi_dosen/akun/ubahsandi.dart';
import 'package:aplikasi_dosen/homepage/home.dart';
import 'package:aplikasi_dosen/pesan/dosen_conversation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class infoakun extends StatefulWidget {
  const infoakun({super.key});

  @override
  State<infoakun> createState() => _infoakunState();
}

class _infoakunState extends State<infoakun> {
  String nama = '';
  String nip = '';
  String fotoUrl = '';
  int _selectedIndex = 2; // index 2 untuk halaman info akun

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama') ?? 'Nama tidak ditemukan';
      nip = prefs.getString('nip') ?? '-';
      fotoUrl = prefs.getString('foto_url') ?? '';
    });

    print('Nama: $nama');
    print('NIP: $nip');
    print('Foto URL: $fotoUrl');
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DosenConversationPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const homepage()),
        );
        break;
      case 2:
        // Sudah di infoakun
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD9D9D9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(15)),
          child: AppBar(
            backgroundColor: const Color(0xFF00712D),
            flexibleSpace: const Padding(
              padding: EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Text(
                    "Informasi Akun",
                    style: TextStyle(
                        fontFamily: 'PoppinsBold',
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  Text(
                    "Universitas Malikussaleh",
                    style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 14,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 34),
            Container(
              width: double.infinity,
              height: 82,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFFF9100),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: fotoUrl.isNotEmpty
                          ? NetworkImage(fotoUrl)
                          : const AssetImage('asset/image/profile.png')
                              as ImageProvider,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selamat Datang',
                          style: TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          nama,
                          style: const TextStyle(
                            fontFamily: 'Poppinsmedium',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          nip,
                          style: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 53,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Status Dosen",
                      style: TextStyle(
                          fontFamily: 'Poppinssemibold', fontSize: 18),
                    ),
                    Container(
                      width: 67,
                      height: 27,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF00712D))),
                      child: const Center(child: Text("Aktif")),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Datadiri()));
              },
              child: menuItem("Data Diri", 'asset/image/User Folder.png'),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const ubahsandi()));
              },
              child: menuItem("Ubah Password", 'asset/image/User Folder.png'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                bool? shouldLogout = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Keluar"),
                      content: const Text("Apakah Anda yakin ingin keluar?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Batal"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Keluar"),
                        ),
                      ],
                    );
                  },
                );

                if (shouldLogout ?? false) {
                  // Hapus token dan data dari SharedPreferences
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear(); // atau prefs.remove('token'); dst

                  // Navigasi ke halaman login
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                }
              },
              child: Container(
                width: double.infinity,
                height: 53,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: const Center(
                  child: Text(
                    "Keluar",
                    style: TextStyle(
                        fontFamily: 'Poppinssemibold',
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Color(0xFF00712D),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Pesan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem(String title, String iconPath) {
    return Container(
      width: double.infinity,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(iconPath),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Poppinssemibold', fontSize: 16),
                ),
              ],
            ),
            const Text(
              ">",
              style: TextStyle(fontFamily: 'Poppinssemibold', fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
