import 'package:aplikasi_dosen/bimbingan/menu_bimbingan.dart';
import 'package:aplikasi_dosen/jadwal_masuk/hari.dart';
import 'package:aplikasi_dosen/materi%20kuliah/materi.dart';
import 'package:flutter/material.dart';

class Menudosen extends StatelessWidget {
  Menudosen({super.key});

  final List<Map<String, dynamic>> products = [
    {
      'image': 'asset/image/Vector.png',
      'title': 'Jadwal Mengajar',
      'page': hari(),
      'color': Color(0xFF00712D),
    },
    {
      'image': 'asset/image/School.png',
      'title': 'Input Nilai',
      'page': MatkulListPage(),
      'color': Color(0xFFFF9100),
    },
    // {
    //   'image': 'asset/image/Exam.png',
    //   'title': 'Input Nilai',
    //   'page': jadwalmasuk(),
    //   'color': Color(0xFF00712D),
    // },
    {
      'image': 'asset/image/student.png',
      'title': 'Bimbingan',
      'page': MahasiswaBimbingan(),
      'color': Color(0xFF00712D),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((product) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (build) => product['page']));
            },
            child: Container(
              width: 100,
              height: 122,
              margin: const EdgeInsets.only(
                left: 20,
                top: 10,
              ),
              decoration: BoxDecoration(
                  color: product['color'],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 111, 110, 110)
                          .withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(2, 4),
                    )
                  ]),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Image.asset(
                      product['image'],
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      product['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppinsmedium',
                        fontSize: 14,
                        color: Color(0xFFFFFFFF),
                        height: 1.1,
                      ),
                    ),
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
