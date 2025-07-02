// lib/jadwal_masuk/jadwal_per_hari.dart
import 'package:flutter/material.dart';
import 'package:aplikasi_dosen/service/jadwal_service.dart';

class JadwalPerHari extends StatefulWidget {
  final String hari;
  const JadwalPerHari({super.key, required this.hari});

  @override
  State<JadwalPerHari> createState() => _JadwalPerHariState();
}

class _JadwalPerHariState extends State<JadwalPerHari> {
  List<dynamic> jadwal = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadJadwal();
  }

  Future<void> loadJadwal() async {
    try {
      final allJadwal = await fetchJadwalDosen();
      final filtered =
          allJadwal.where((item) => item['hari'] == widget.hari).toList();
      setState(() {
        jadwal = filtered;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      // bisa tampilkan snackbar jika ingin
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
                    "Jadwal Kuliah",
                    style: TextStyle(
                        fontFamily: 'PoppinsBold',
                        fontSize: 25,
                        color: Color(0xFFFFFFFF)),
                  ),
                  Text(
                    widget.hari,
                    style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 20,
                        color: Color(0xFFFFFFFF)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, color: Colors.red),
                    label: Text("Kembali",
                        style: TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                ),
                Expanded(
                  child: jadwal.isEmpty
                      ? Center(
                          child: Text(
                            "Tidak ada jadwal pada hari ${widget.hari}",
                            style: TextStyle(fontFamily: 'PoppinsRegular'),
                          ),
                        )
                      : ListView.builder(
                          itemCount: jadwal.length,
                          itemBuilder: (context, index) {
                            final item = jadwal[index];
                            final kelas = item['kelas'];
                            final matkul = kelas['mata_kuliah'];
                            return Card(
                              color: Color(0xFFBEE4BE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      matkul['kode_matkul'] ?? '',
                                      style: TextStyle(
                                        fontFamily: 'Poppinssemibold',
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      kelas['nama_kelas'],
                                      style: TextStyle(
                                          fontFamily: 'Poppinssemibold',
                                          fontSize: 14),
                                    ),
                                    Text(
                                      matkul['nama_matkul'],
                                      style: TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${item['jam_mulai']} - ${item['jam_selesai']}",
                                          style: TextStyle(
                                              fontFamily: 'Poppinssemibold',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          item['ruangan'],
                                          style: TextStyle(
                                              fontFamily: 'Poppinssemibold',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
