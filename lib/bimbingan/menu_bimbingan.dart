import 'package:aplikasi_dosen/bimbingan/detailskripsi.dart';
import 'package:flutter/material.dart';

class MahasiswaBimbingan extends StatelessWidget {
  final List<Map<String, String>> mahasiswaList = [
    {
      'nama': 'RoBet',
      'nim': '230180078',
      'prodi': 'Sistem Informasi',
      'semester': '8',
      'dosen': 'Pak Dosen. M.Kom',
      'judul': 'Sistem Informasi Manajemen',
      'bimbingan': 'Bimbingan Pertama',
      'isi': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
    },
    {
      'nama': 'Beti',
      'nim': '230180074',
      'prodi': 'Sistem Informasi',
      'semester': '8',
      'dosen': 'Pak Dosen. M.Kom',
      'judul': 'Analisis Data Big Data',
      'bimbingan': 'Bimbingan Kedua',
      'isi': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            child: AppBar(
              backgroundColor: Color(0xFF00712D),
              flexibleSpace: Padding(
                padding: EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Text(
                      "Jadwal Kuliah",
                      style: TextStyle(
                          fontFamily: 'PoppinsBold',
                          fontSize: 25,
                          color: Color(0xFFFFFFFF)),
                    ),
                    Text(
                      "Universitas Malikussaleh",
                      style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 14,
                          color: Color(0xFFFFFFFF)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.red),
                label: Text(
                  "Kembali",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: mahasiswaList.length,
                itemBuilder: (context, index) {
                  var mahasiswa = mahasiswaList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailSkripsiPage(mahasiswa: mahasiswa),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.orange[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRow("Nama", mahasiswa['nama']!),
                            _buildRow("NIM", mahasiswa['nim']!),
                            _buildRow("Prodi", mahasiswa['prodi']!),
                            _buildRow("Semester", mahasiswa['semester']!),
                            _buildRow("Dosen Pembimbing", mahasiswa['dosen']!),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(value, style: TextStyle(fontSize: 14, color: Colors.white)),
          ],
        ),
        SizedBox(height: 4),
        Divider(color: Colors.white, thickness: 1),
      ],
    );
  }
}
