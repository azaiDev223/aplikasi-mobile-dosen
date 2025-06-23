import 'package:flutter/material.dart';

class selasa extends StatelessWidget {
  const selasa({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> jadwal = [
      {
        'kode': 'TSI 1943',
        'kelas': 'A1',
        'waktu': '08.00 - 10.00',
        'mataKuliah': 'Pemrograman Mobile 2',
        'ruang': 'R-1, SI',
      },
      {
        'kode': 'TSI 1945',
        'kelas': 'A2',
        'waktu': '10.01 - 12.30',
        'mataKuliah': 'Pemrograman Mobile 2',
        'ruang': 'R-1, SI',
      },
      {
        'kode': 'TSI 1944',
        'kelas': 'A3',
        'waktu': '14.00 - 16.30',
        'mataKuliah': 'Pemrograman Mobile 2',
        'ruang': 'R-1, SI',
      },
    ];

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
                      "Selasa",
                      style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 20,
                          color: Color(0xFFFFFFFF)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tombol Kembali
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.red),
                label: Text(
                  "Kembali",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ),
            // List Jadwal
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: jadwal.length,
                  itemBuilder: (context, index) {
                    final data = jadwal[index];
                    return Card(
                      color: Color(0xFFBEE4BE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['kode']!,
                              style: TextStyle(
                                fontFamily: 'Poppinssemibold',
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              data['kelas']!,
                              style: TextStyle(
                                  fontFamily: 'Poppinssemibold', fontSize: 14),
                            ),
                            Text(
                              data['mataKuliah']!,
                              style: TextStyle(
                                fontFamily: 'PoppinsBold',
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['waktu']!,
                                  style: TextStyle(
                                      fontFamily: 'Poppinssemibold',
                                      fontSize: 14),
                                ),
                                Text(
                                  data['ruang']!,
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
            ),
            SizedBox(height: 10),
            // Tombol Cetak Jadwal
            ElevatedButton.icon(
              onPressed: () {
                // Tambahkan aksi cetak jadwal
              },
              icon: Icon(Icons.print, color: Colors.white),
              label: Text(
                "Cetak Jadwal",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'PoppinsBold',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00712D),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}