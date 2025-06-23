import 'package:aplikasi_dosen/akun/datadiri.dart';
import 'package:aplikasi_dosen/akun/ubahsandi.dart';
import 'package:flutter/material.dart';

class infoakun extends StatefulWidget {
  const infoakun({super.key});

  @override
  State<infoakun> createState() => _infoakunState();
}

class _infoakunState extends State<infoakun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD9D9D9),
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
                      "Informasi Akun",
                      style: TextStyle(
                          fontFamily: 'PoppinsBold',
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    Text(
                      "Universitas Malikussaleh",
                      style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 14,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          )),
      body: Column(
        children: [
          SizedBox(
            height: 34,
          ),
          Container(
            width: double.infinity,
            height: 113,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFFF9100)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 89,
                  height: 89,
                  child: Image.asset('asset/image/profile.png'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 12,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    Text(
                      'Pulan Bin Fulan',
                      style: TextStyle(
                        fontFamily: 'Poppinsmedium',
                        fontSize: 16,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    Text(
                      '230199080',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 12,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 53,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status Mahasiswa",
                    style:
                        TextStyle(fontFamily: 'Poppinssemibold', fontSize: 18),
                  ),
                  Container(
                    width: 67,
                    height: 27,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFF00712D))),
                    child: Center(
                      child: Text("Aktif"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext) => datadiri()));
            },
            child: Container(
              width: double.infinity,
              height: 53,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('asset/image/User Folder.png'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Data Diri",
                          style: TextStyle(
                              fontFamily: 'Poppinssemibold', fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ">",
                          style: TextStyle(
                              fontFamily: 'Poppinssemibold', fontSize: 25),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext) => const ubahsandi()));
            },
            child: Container(
              width: double.infinity,
              height: 53,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('asset/image/User Folder.png'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Ubah Password",
                          style: TextStyle(
                              fontFamily: 'Poppinssemibold', fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ">",
                          style: TextStyle(
                              fontFamily: 'Poppinssemibold', fontSize: 25),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              // Konfirmasi sebelum logout
              bool? shouldLogout = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Keluar"),
                    content: const Text("Apakah Anda yakin ingin keluar?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false); // Batal
                        },
                        child: const Text("Batal"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true); // Lanjutkan
                        },
                        child: const Text("Keluar"),
                      ),
                    ],
                  );
                },
              );

              // Jika pengguna memilih untuk logout
              if (shouldLogout ?? false) {
                try {
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (BuildContext) => const LoginTwo()));
                } catch (e) {
                  // Menampilkan pesan error jika logout gagal
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Gagal logout: $e"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: Container(
              width: double.infinity,
              height: 53,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  "Keluar",
                  style: TextStyle(
                      fontFamily: 'Poppinssemibold',
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
