import 'package:aplikasi_dosen/materi%20kuliah/daftarmateri.dart';
import 'package:flutter/material.dart';

class Materikuliah extends StatelessWidget {
  const Materikuliah({super.key});

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
                      "Materi Kuliah",
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
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.red,
                  ),
                  label: Text(
                    "Kembali",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  )),
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
                    "Semester",
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
          Daftarmateri(),
        ],
      ),
    );
  }
}
