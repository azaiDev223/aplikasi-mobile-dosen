import 'package:flutter/material.dart';

class TambahMateriPage extends StatelessWidget {
  const TambahMateriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text("Tambah Materi"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Judul Materi",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Deskripsi Materi",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Center(child: Text("Simpan Materi", style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}

class LihatMateriPage extends StatelessWidget {
  const LihatMateriPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> materiList = [
      {'judul': 'Materi 1', 'deskripsi': 'Ini adalah materi pertama'},
      {'judul': 'Materi 2', 'deskripsi': 'Ini adalah materi kedua'},
      {'judul': 'Materi 3', 'deskripsi': 'Ini adalah materi ketiga'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text("Lihat Materi"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: materiList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(materiList[index]['judul']!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(materiList[index]['deskripsi']!),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
