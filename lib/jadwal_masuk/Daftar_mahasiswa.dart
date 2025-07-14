import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaftarMahasiswaPage extends StatefulWidget {
  final int jadwalKuliahId;
  const DaftarMahasiswaPage({super.key, required this.jadwalKuliahId});

  @override
  State<DaftarMahasiswaPage> createState() => _DaftarMahasiswaPageState();
}

class _DaftarMahasiswaPageState extends State<DaftarMahasiswaPage> {
  List<dynamic> mahasiswas = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchMahasiswa();
  }

  Future<void> fetchMahasiswa() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(
          'http://192.168.112.140:8000/api/daftar-mahasiswa/${widget.jadwalKuliahId}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        mahasiswas = data;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      print('Gagal fetch mahasiswa: ${response.body}');
    }
  }

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
                    "Daftar Mahasiswa",
                    style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Universitas Malikussaleh",
                    style: TextStyle(
                      fontFamily: 'PoppinsRegular',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : mahasiswas.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada mahasiswa',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'PoppinsRegular',
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: mahasiswas.length,
                  itemBuilder: (context, index) {
                    final mhs = mahasiswas[index];
                    return ListTile(
                      title: Text(mhs['nama']),
                      subtitle: Text(
                          "Semester: ${mhs['semester'] ?? '-'} | Tahun: ${mhs['tahun_akademik'] ?? '-'}"),
                      leading: CircleAvatar(child: Text('${index + 1}')),
                    );
                  },
                ),
    );
  }
}
