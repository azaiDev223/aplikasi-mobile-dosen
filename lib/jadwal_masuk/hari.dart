import 'package:aplikasi_dosen/jadwal_masuk/detail%20hari/jumat.dart';
import 'package:aplikasi_dosen/jadwal_masuk/detail%20hari/kamis.dart';
import 'package:aplikasi_dosen/jadwal_masuk/detail%20hari/rabu.dart';
import 'package:aplikasi_dosen/jadwal_masuk/detail%20hari/selasa.dart';
import 'package:aplikasi_dosen/jadwal_masuk/detail%20hari/senin.dart';
import 'package:flutter/material.dart';

class hari extends StatelessWidget {
  hari({super.key});

  final List<Map<String, dynamic>> Jadwal = [
    {
      'hari': 'Senin',
      'color': Color(0xFF00712D),
      'page' : Senin(),
    },
    {
      'hari': 'Selasa',
      'color': Color(0xFFFF9100),
      'page' : selasa(),
    },
    {
      'hari': 'Rabu',
      'color': Color(0xFF00712D),
      'page' : rabu(),
    },
    {
      'hari': 'Kamis',
      'color': Color(0xFFFF9100),
      'page' : kamis(),
    },
    {
      'hari': 'Jumat',
      'color': Color(0xFF00712D),
      'page' : jumat(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: Jadwal.map((jadwal) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (build) => jadwal['page']));
            },
            child: Container(
              width: double.infinity,
              height: 53,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: jadwal['color']),
              child: Center(
                child: Text(
                  jadwal['hari'],
                  style: TextStyle(
                      fontFamily: 'Poppinssemibold',
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
