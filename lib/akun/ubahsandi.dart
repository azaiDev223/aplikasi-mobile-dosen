import 'package:flutter/material.dart';

class ubahsandi extends StatefulWidget {
  const ubahsandi({super.key});

  @override
  State<ubahsandi> createState() => _ubahsandiState();
}

class _ubahsandiState extends State<ubahsandi> {
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
                      "Ubah Passorwd",
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
      body: Column(children: [
        SizedBox(
          height: 18,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("< Kembali",
                    style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      fontSize: 25,
                    )),
              )),
        ),
        SizedBox(
          height: 18,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 5),
            child: Text(
              'Password Lama',
              style: TextStyle(fontFamily: 'Poppinsmedium', fontSize: 16),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0XFFCCDBBF)),
          child: TextFormField(
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: InputBorder.none,
                hintText: 'masukkan password',
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color(0xff00712D),
                )),
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 5),
            child: Text(
              'Password Baru',
              style: TextStyle(fontFamily: 'Poppinsmedium', fontSize: 16),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0XFFCCDBBF)),
          child: TextFormField(
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: InputBorder.none,
                hintText: 'masukkan password',
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color(0xff00712D),
                )),
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 5),
            child: Text(
              'Konfirmasi Password Baru',
              style: TextStyle(fontFamily: 'Poppinsmedium', fontSize: 16),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0XFFCCDBBF)),
          child: TextFormField(
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: InputBorder.none,
                hintText: 'masukkan password',
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color(0xff00712D),
                )),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                color: Color(0xff1400FF),
                                child: Center(
                                    child: const Text(
                                  "oke",
                                  style: TextStyle(
                                    fontFamily: 'Poppinsmedium',
                                    fontSize: 14,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                )),
                              ),
                            )
                          ],
                          title: const Text(
                            "Password berhasil diubah",
                            style: TextStyle(
                                fontFamily: 'Poppinsmedium', fontSize: 20),
                          ),
                          contentPadding: const EdgeInsets.all(30),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [Image.asset('asset/image/beenhere.png')],
                          ),
                        ));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF9100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size(double.infinity, 56)),
              child: Center(
                  child: Text(
                'Simpan',
                style: TextStyle(
                  fontFamily: 'Poppinsmedium',
                  fontSize: 14,
                  color: Color(0xFFFFFFFF),
                ),
              ))),
        )
      ]),
    );
  }
}
