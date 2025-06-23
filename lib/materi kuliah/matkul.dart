import 'package:aplikasi_dosen/materi%20kuliah/tambah_materi.dart';
import 'package:flutter/material.dart';

class MataKuliahPage extends StatelessWidget {
  final String semester;
  final List<String> mataKuliahList;

  const MataKuliahPage(
      {Key? key, required this.semester, required this.mataKuliahList})
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
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.red,
                    size: 20,
                  )),
            ),
          )),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: mataKuliahList.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.orange[700],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text(
                mataKuliahList[index],
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (build) => MateriPage()));
              },
            ),
          );
        },
      ),
    );
  }
}
