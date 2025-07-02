import 'package:aplikasi_dosen/akun/editakun.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Datadiri extends StatefulWidget {
  const Datadiri({super.key});

  @override
  State<Datadiri> createState() => _DatadiriState();
}

class _DatadiriState extends State<Datadiri> {
  String nama = '';
  String nip = '';
  String email = '';
  String jenisKelamin = '';
  String tanggalLahir = '';
  String noHp = '';
  String programStudi = '';

  @override
  void initState() {
    super.initState();
    loadDataDosen();
  }

  Future<void> loadDataDosen() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama') ?? '';
      nip = prefs.getString('nip') ?? '';
      email = prefs.getString('email') ?? '';
      jenisKelamin = prefs.getString('jenis_kelamin') ?? '';
      tanggalLahir = prefs.getString('tanggal_lahir') ?? '';
      noHp = prefs.getString('no_hp') ?? '';
      programStudi = prefs.getString('program_studi') ?? 'Tidak ditemukan';
    });
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
                  ),
                ],
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.red),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoField("Nama", nama),
                  _buildInfoField("NIP", nip),
                  _buildInfoField("Email", email),
                  _buildInfoField("Program Studi", programStudi),
                  _buildInfoField("Jenis Kelamin", jenisKelamin),
                  _buildInfoField("Tanggal Lahir", tanggalLahir),
                  _buildInfoField("No HP", noHp),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditAkun()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1400FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Center(
                  child: Text(
                    "Edit Data Diri",
                    style: TextStyle(
                      fontFamily: 'Poppinsmedium',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontFamily: 'Poppinsmedium', fontSize: 16)),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppinssemibold',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
