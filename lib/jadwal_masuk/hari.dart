// lib/jadwal_masuk/hari.dart
import 'package:aplikasi_dosen/homepage/home.dart';
import 'package:aplikasi_dosen/jadwal_masuk/menu_jadwal.dart';
import 'package:flutter/material.dart';


class hari extends StatelessWidget {
  hari({super.key});

  final List<Map<String, dynamic>> Jadwal = [
    {'hari': 'Senin', 'color': Color(0xFF00712D)},
    {'hari': 'Selasa', 'color': Color(0xFFFF9100)},
    {'hari': 'Rabu', 'color': Color(0xFF00712D)},
    {'hari': 'Kamis', 'color': Color(0xFFFF9100)},
    {'hari': 'Jumat', 'color': Color(0xFF00712D)},
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
      body: ListView(
        children: [
          // Tombol kembali
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (build) => homepage()));
                },
                child: Text(
                  "< Kembali",
                  style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Box pemberitahuan
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 9, bottom: 10),
            child: Container(
              color: Color(0xffD9D9D9),
              width: 340,
              height: 51,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "PEMBERITAHUAN  :\nDIMOHON DOSEN AGAR MASUK KE KELAS TEPAT WAKTU ",
                  style: TextStyle(
                    fontFamily: 'Poppinssemibold',
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Label "Hari"
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Container(
                  width: 320,
                  height: 2,
                  color: Color(0xFFFF9100),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Hari",
                    style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 320,
                  height: 2,
                  color: Color(0xFFFF9100),
                ),
              ],
            ),
          ),

          // List hari
          Column(
            children: Jadwal.map((jadwal) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => JadwalPerHari(hari: jadwal['hari']),
                  ));
                },
                child: Container(
                  width: double.infinity,
                  height: 53,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: jadwal['color'],
                  ),
                  child: Center(
                    child: Text(
                      jadwal['hari'],
                      style: TextStyle(
                        fontFamily: 'Poppinssemibold',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
