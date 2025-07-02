import 'dart:convert';
import 'package:aplikasi_dosen/materi%20kuliah/input_nilai_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MatkulListPage extends StatefulWidget {
  const MatkulListPage({super.key});

  @override
  State<MatkulListPage> createState() => _MatkulListPageState();
}

class _MatkulListPageState extends State<MatkulListPage> {
  List<dynamic> matkulList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMatkul();
  }

  Future<void> fetchMatkul() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('http://192.168.131.140:8000/api/input-nilai/matkul'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        matkulList = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Gagal mengambil data: ${response.body}');
    }
  }

  void gotoMahasiswaPage(int jadwalKuliahId, int mataKuliahId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MahasiswaNilaiPage(
          jadwalKuliahId: jadwalKuliahId,
          mataKuliahId: mataKuliahId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Mata Kuliah',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'PoppinsMedium',
          ),
        ),
        backgroundColor: const Color(0xFF00712D),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : matkulList.isEmpty
              ? const Center(
                  child: Text(
                    'Tidak ada data mata kuliah.',
                    style: TextStyle(fontFamily: 'PoppinsRegular'),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  itemCount: matkulList.length,
                  itemBuilder: (context, index) {
                    final jadwal = matkulList[index];
                    final kelas = jadwal['kelas'];
                    final matkul = kelas['mata_kuliah'];

                    return GestureDetector(
                      onTap: () => gotoMahasiswaPage(
                        jadwal['id'],
                        matkul['id'],
                      ),
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                matkul['nama_matkul'] ?? '-',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'PoppinsMedium',
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.class_,
                                      size: 18, color: Colors.grey),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Kelas: ${kelas['nama_kelas']}',
                                    style: const TextStyle(
                                        fontFamily: 'PoppinsRegular'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      size: 18, color: Colors.grey),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${jadwal['hari']} • ${jadwal['jam_mulai']} - ${jadwal['jam_selesai']}',
                                    style: const TextStyle(
                                        fontFamily: 'PoppinsRegular'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.meeting_room,
                                      size: 18, color: Colors.grey),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Ruangan: ${jadwal['ruangan']}',
                                    style: const TextStyle(
                                        fontFamily: 'PoppinsRegular'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
