import 'package:aplikasi_dosen/akun/infoakun.dart';
import 'package:aplikasi_dosen/homepage/home.dart';
import 'package:aplikasi_dosen/pesan/controllers/dosen_conversation_controller.dart';
import 'package:aplikasi_dosen/pesan/dosen_chat_page.dart';
import 'package:aplikasi_dosen/pesan/models/mahasiswa_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DosenConversationPage extends StatefulWidget {
  const DosenConversationPage({super.key});

  @override
  State<DosenConversationPage> createState() => _DosenConversationPageState();
}

class _DosenConversationPageState extends State<DosenConversationPage> {
  final DosenConversationController controller =
      Get.put(DosenConversationController());

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Halaman ini (Pesan)
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const homepage()),
        );
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
      backgroundColor: const Color(0xFFF2F2F2),
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
                    "Pesan Mahasiswa",
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.conversationList.isEmpty) {
          return const Center(
              child: Text("Anda belum memiliki mahasiswa bimbingan."));
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: controller.conversationList.length,
          itemBuilder: (context, index) {
            final mahasiswa = controller.conversationList[index];
            return _buildMahasiswaTile(mahasiswa);
          },
        );
      }),
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
            currentIndex: _currentIndex,
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

  Widget _buildMahasiswaTile(Mahasiswa mahasiswa) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: ListTile(
        onTap: () {
          Get.to(() => DosenChatPage(
                partnerId: mahasiswa.id,
                partnerName: mahasiswa.nama,
              ));
        },
        leading: CircleAvatar(
          radius: 25,
          backgroundImage:
              (mahasiswa.foto != null) ? NetworkImage(mahasiswa.foto!) : null,
          backgroundColor: const Color(0xFFE0E0E0),
          child: (mahasiswa.foto == null)
              ? Text(
                  mahasiswa.nama[0],
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                )
              : null,
        ),
        title: Text(
          mahasiswa.nama,
          style: const TextStyle(
              fontFamily: 'PoppinsMedium', fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "NIM: ${mahasiswa.nim}",
          style: const TextStyle(fontFamily: 'PoppinsRegular'),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
