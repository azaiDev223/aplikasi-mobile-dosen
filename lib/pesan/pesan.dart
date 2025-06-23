
import 'package:aplikasi_dosen/pesan/detailpesan.dart';

import 'package:flutter/material.dart';

class Pesan extends StatefulWidget {
  const Pesan({super.key});

  @override
  State<Pesan> createState() => _PesanState();
}

class _PesanState extends State<Pesan> {
  final List<Map<String, String>> messages = const [
    {
      "sender": "Adm Prodi",
      "title": "Pembayaran UKT",
      "content": "Lorem ipsum dolor sit amet, conse...."
    },
    {
      "sender": "Adm Prodi",
      "title": "Pengisian KRS",
      "content": "Harap segera mengisi KRS sebelum...."
    },
    {
      "sender": "Adm Fakultas",
      "title": "Jadwal Ujian",
      "content": "Jadwal ujian semester telah tersedia...."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(15)),
          child: AppBar(
            backgroundColor: Color(0xFF00712D),
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Pesan",
                    style: TextStyle(
                        fontFamily: 'PoppinsBold',
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "Universitas Malikussaleh",
                      style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPesan(
                        sender: message["sender"]!,
                        title: message["title"]!,
                        content: message["content"]!,
                      )));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200]),
              child: Row(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                  ),
                  const SizedBox(width: 19),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message["sender"]!,
                        style: const TextStyle(
                            fontFamily: 'PoppinsMedium', fontSize: 16),
                      ),
                      Text(
                        message["title"]!,
                        style: const TextStyle(
                            fontFamily: 'PoppinsMedium', fontSize: 12),
                      ),
                      Text(
                        message["content"]!,
                        style: const TextStyle(
                            fontFamily: 'PoppinsMedium', fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),

    );
  }
}
