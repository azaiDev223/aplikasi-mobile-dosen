import 'package:flutter/material.dart';

class DetailSkripsiPage extends StatelessWidget {
  final Map<String, String> mahasiswa;

  const DetailSkripsiPage({Key? key, required this.mahasiswa})
      : super(key: key);

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
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.red,
                    size: 20,
                  ),
                )),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 📌 **Card Informasi Mahasiswa**
              Card(
                color: Colors.orange[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mahasiswa['nama']!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      Text(mahasiswa['judul']!,
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          mahasiswa['bimbingan']!,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),

              /// 📌 **Container untuk isi skripsi**
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ISI",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 5),

                    /// ✅ Gunakan `SizedBox` untuk membatasi tinggi teks
                    SizedBox(
                      height:
                          300, // Batas tinggi teks agar tidak memenuhi layar
                      child: SingleChildScrollView(
                        child: Text(
                          mahasiswa['isi']!,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    /// 📌 **File Skripsi**
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xffABA3A3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.picture_as_pdf, color: Colors.black54),
                            SizedBox(width: 8),
                            Text("SKRIPSI.PDF",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                  height: 20), // Memberikan sedikit ruang sebelum tombol bawah
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {},
                child: Text("ACC", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {},
                child: Text("BALAS", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
