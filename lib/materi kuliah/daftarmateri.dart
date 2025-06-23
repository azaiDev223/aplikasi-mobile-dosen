import 'package:aplikasi_dosen/materi%20kuliah/matkul.dart';
import 'package:flutter/material.dart';

class Daftarmateri extends StatelessWidget {
  Daftarmateri({super.key});

  final List<Map<String, dynamic>> semester = [
    {
      'semester': 'Semester 1',
      'color': Color(0xFF00712D),
      'mata_kuliah' : ['basis data','mobile 2']
      //   'page' : Senin(),
    },
    {
      'semester': 'Semester 2',
      'color': Color(0xFFFF9100),
      'mata_kuliah': ['Pemrograman Dasar', 'Matematika Diskrit', 'Basis Data 1'],
      //   'page' : selasa(),
    },
    {
      'semester': 'Semester 3',
      'color': Color(0xFF00712D),
      'mata_kuliah': ['Pemrograman Dasar', 'Matematika Informatika', 'Basis Data 1'],
      //   'page' : rabu(),
    },
    {
      'semester': 'Semester 4',
      'color': Color(0xFFFF9100),
      'mata_kuliah': ['Pemrograman Basis Data', 'Basis Data 1'],
      //   'page' : kamis(),
    },
    {
      'semester': 'Semester 5',
      'color': Color(0xFF00712D),
      'mata_kuliah': [ 'Basis Data 1'],
      //   'page' : jumat(),
    },
    {
      'semester': 'Semester 6',
      'color': Color(0xFFFF9100),
      'mata_kuliah': ['Matematika Diskrit'],
      //   'page' : kamis(),
    },
    {
      'semester': 'Semester 7',
      'color': Color(0xFF00712D),
      'mata_kuliah': ['Pemrograman Dasar', 'Matematika Diskrit', 'Basis Data 1'],
      //   'page' : jumat(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: semester.map((semester) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MataKuliahPage(
                    semester: semester['semester'],
                    mataKuliahList: List<String>.from(semester['mata_kuliah']),
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 53,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: semester['color']),
              child: Center(
                child: Text(
                  semester['semester'],
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
