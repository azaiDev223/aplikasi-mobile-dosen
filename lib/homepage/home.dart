import 'package:aplikasi_dosen/akun/infoakun.dart';
import 'package:aplikasi_dosen/pesan/dosen_conversation_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aplikasi_dosen/homepage/menudosen.dart';
import 'package:aplikasi_dosen/homepage/pengumuman.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String nama = '';
  String nip = '';
  String fotoUrl = '';
  int _selectedIndex = 1; // index tengah untuk homepage

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
    if (index == _selectedIndex)
      return; // Jangan lakukan apapun jika sedang di tab itu
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const DosenConversationPage()),
        );
        break;
      case 1:
        // Homepage (tidak perlu berpindah)
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const infoakun()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(15)),
          child: AppBar(
            backgroundColor: const Color(0xFF00712D),
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Sistem Akademik",
                    style: TextStyle(
                        fontFamily: 'PoppinsBold',
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "Universitas Malikussaleh",
                      style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
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
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Menu",
                style: TextStyle(
                  fontFamily: 'Poppinsmedium',
                  fontSize: 16,
                  color: Color(0xFF00712D),
                ),
              ),
            ),
          ),
          Menudosen(),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pengumuman",
                style: TextStyle(
                  fontFamily: 'Poppinsmedium',
                  fontSize: 16,
                  color: Color(0xFF00712D),
                ),
              ),
            ),
          ),
          const Pengumuman(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          height: 70, // Ubah tinggi sesuai kebutuhan
          decoration: const BoxDecoration(
            color: Color(0xFF00712D), // Hijau
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent, // biar ikut Container
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: _selectedIndex,
            onTap: (int index) {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DosenConversationPage()),
                  );
                  break;
                case 1:
                  // Sudah di homepage
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const infoakun()),
                  );
                  break;
              }
            },
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
}
