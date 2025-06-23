import 'package:aplikasi_dosen/homepage/home.dart';
import 'package:aplikasi_dosen/jadwal_masuk/hari.dart';
import 'package:flutter/material.dart';

class jadwalmasuk extends StatelessWidget {
  const jadwalmasuk({super.key});

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
      body: ListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (build) => homepage()));
                  },
                  child: Text(
                    "< Kembali",
                    style: TextStyle(
                        fontFamily: 'PoppinsBold',
                        fontSize: 20,
                        color: Colors.black),
                  )),
            ),
          ),
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
                      color: Colors.black),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
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
                        color: Colors.black),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 320,
                  height: 2,
                  color: Color(0xFFFF9100),
                )
              ],
            ),
          ),
          hari(),
        ],
      ),
    );
  }
}
