import 'package:flutter/material.dart';

class DetailPengumuman extends StatelessWidget {
  final Map<String, dynamic> pengumuman;

  const DetailPengumuman({super.key, required this.pengumuman});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "< Kembali",
                      style: TextStyle(
                        fontFamily: 'PoppinsBold',
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              height: 515,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.only(bottom: 40),
              color: Color(0xffD9D9D9),
              child: Column(
                children: [
                  // Header Pengumuman
                  Container(
                    width: double.infinity,
                    height: 82,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      color: Color(0xFFFF9100),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: Text(
                                pengumuman['judul']!,
                                style: TextStyle(
                                  fontFamily: 'PoppinsBold',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, top: 20),
                              child: Text(
                                pengumuman['kategori']!,
                                style: const TextStyle(
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: Text(
                                pengumuman['waktu'] + (' WIB'),
                                style: TextStyle(
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 10),
                        child: Text(
                          pengumuman['isi'] ?? '',
                          style: const TextStyle(
                            fontFamily: 'Poppinsmedium',
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
