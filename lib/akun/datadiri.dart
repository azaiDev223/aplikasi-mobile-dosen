import 'package:aplikasi_dosen/akun/editakun.dart';
import 'package:aplikasi_dosen/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class datadiri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return Scaffold(
      backgroundColor: Color(0xffD9D9D9),
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
                    "Informasi Akun",
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
            leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.red,
                    size: 20,
                  ),
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
                  _buildInfoField("Nama", user.name),
                  _buildInfoField("NIM", user.nim),
                  _buildInfoField("Fakultas", user.fakultas),
                  _buildInfoField("Prodi", user.prodi),
                  _buildInfoField("Tempat Lahir", user.tempatLahir),
                  _buildInfoField("Tanggal Lahir", user.tanggalLahir),
                  _buildInfoField("Alamat", user.alamat),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditAkun()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1400FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(double.infinity, 65),
                ),
                child: Center(
                  child: Text(
                    "Edit Data",
                    style: TextStyle(
                      fontFamily: 'Poppinsmedium',
                      fontSize: 14,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk menampilkan data dengan gaya serupa input field
  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppinsmedium',
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'Poppinssemibold',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
