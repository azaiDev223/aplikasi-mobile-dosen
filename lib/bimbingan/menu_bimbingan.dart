import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MahasiswaBimbingan extends StatefulWidget {
  const MahasiswaBimbingan({super.key});

  @override
  State<MahasiswaBimbingan> createState() => _MahasiswaBimbinganState();
}

class _MahasiswaBimbinganState extends State<MahasiswaBimbingan> {
  List<dynamic> bimbinganList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBimbingan();
  }

  Future<void> fetchBimbingan() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('http://192.168.131.140:8000/api/bimbingan-dosen'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        bimbinganList = data['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      debugPrint('Gagal mengambil data bimbingan');
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
                children: const [
                  Text(
                    "Bimbingan Mahasiswa",
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bimbinganList.isEmpty
              ? const Center(child: Text("Belum ada data bimbingan."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: bimbinganList.length,
                  itemBuilder: (context, index) {
                    final item = bimbinganList[index];
                    return Card(
                      color: Colors.orange[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildRow("Nama", item['mahasiswa']['nama']),
                            buildRow("NIM",
                                item['mahasiswa']['nim']?.toString() ?? '-'),
                            buildRow(
                                "Angkatan",
                                item['mahasiswa']['angkatan']?.toString() ??
                                    '-'),
                            buildRow("Topik", item['topik']),
                            buildRow("Tanggal", item['tanggal_bimbingan']),
                            buildRow("Status", item['status']),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget buildRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(value,
                style: const TextStyle(fontSize: 14, color: Colors.white)),
          ],
        ),
        const SizedBox(height: 4),
        const Divider(color: Colors.white, thickness: 1),
      ],
    );
  }
}
