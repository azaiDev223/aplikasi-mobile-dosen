import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_pengumuman.dart';

class Pengumuman extends StatefulWidget {
  const Pengumuman({super.key});

  @override
  _PengumumanState createState() => _PengumumanState();
}

class _PengumumanState extends State<Pengumuman> {
  List<Map<String, dynamic>> pengumumanList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPengumuman();
  }

  Future<void> fetchPengumuman() async {
    try {
      final url = Uri.parse('http://192.168.131.140:8000/api/pengumuman');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          pengumumanList = data.cast<Map<String, dynamic>>();
          isLoading = false;
        });
      } else {
        print('Gagal mengambil data: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: pengumumanList.map((pengumuman) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPengumuman(
                          pengumuman: {
                            'judul': pengumuman['judul'] ?? 'Tanpa Judul',
                            'kategori': pengumuman['kategori'] ?? 'Umum',
                            'isi': pengumuman['isi'] ?? 'tidak ada isi',
                            'waktu': pengumuman['updated_at'] ??
                                '', // gunakan 'isi' dari API
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBE6),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x20000000),
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pengumuman['judul'] ?? 'Tanpa Judul',
                          style: const TextStyle(
                            fontFamily: 'PoppinsMedium',
                            fontSize: 16,
                            color: Color(0xFF00712D),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          pengumuman['kategori'] ?? 'Umum',
                          style: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 12,
                            color: Color(0x8000712D),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 5,
                              height: 60,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                pengumuman['isi'] ?? '',
                                style: const TextStyle(
                                  fontFamily: 'PoppinsMedium',
                                  fontSize: 12,
                                  color: Color(0x60000000),
                                ),
                                textAlign: TextAlign.justify,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
  }
}
