import 'package:aplikasi_dosen/login%20dan%20register/login.dart';
import 'package:flutter/material.dart';


List tampilandata = [
  {
    "judul": "Sistem Akademik",
    "img": "asset/image/gambar1.png",
    "desk": "aplikasi akademi diperuntukkan kepada seluruh mahasiswa UBE "
  },
  {
    "judul": "Kritik Saran",
    "img": "asset/image/gambar2.png",
    "desk": "Gunakan live chat untuk mempermudah menanyakan masalah"
  },
  {
    "judul": "Portal",
    "img": "asset/image/gambar3.png",
    "desk":
        "Pengaturan Tagihan,Pengisisan KRS Dan Mahasiswa ada dalam satu gengaman"
  },
];

class Tampilan extends StatefulWidget {
  const Tampilan({super.key});

  @override
  State<Tampilan> createState() => _TampilanState();
}

class _TampilanState extends State<Tampilan> {
  final PageController pageController = PageController();
  int currentpage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView.builder(
              controller: pageController,
              onPageChanged: (n) {
                print(n.toString());
                setState(() {
                  currentpage = n;
                });
              },
              itemCount: tampilandata.length,
              itemBuilder: (_, i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 62)),
                    Text(
                      tampilandata[i]['judul'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "PoppinsEkstraBold",
                        fontSize: 30,
                        color: Color(0xff00712D),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 70)),
                    Image.asset(
                      tampilandata[i]['img'],
                      // width: double.infinity,
                      height: 244,
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20)),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 94, 10, 0),
                      child: Text(tampilandata[i]['desk'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            fontSize: 16,
                          )),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 40)),
                  ],
                );
              }),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Wrap(
                spacing: 13,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceIn,
                    decoration: BoxDecoration(
                        color: currentpage == 0
                            ? Color(0xff00712D)
                            : const Color.fromARGB(255, 200, 192, 192),
                        borderRadius: BorderRadius.circular(100)),
                    width: 13,
                    height: 13,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceIn,
                    decoration: BoxDecoration(
                        color: currentpage == 1
                            ? Color(0xff00712D)
                            : const Color.fromARGB(255, 200, 192, 192),
                        borderRadius: BorderRadius.circular(100)),
                    width: 13,
                    height: 13,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceIn,
                    decoration: BoxDecoration(
                        color: currentpage == 2
                            ? Color(0xff00712D)
                            : const Color.fromARGB(255, 200, 192, 192),
                        borderRadius: BorderRadius.circular(100)),
                    width: 13,
                    height: 13,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: GestureDetector(
                onTap: () {
                  if (currentpage == 2) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => const LoginTwo()));
                  } else
                    (pageController.animateToPage(currentpage + 1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut));
                  print("lanjut");
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                      color: Color(0xff00712D),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    currentpage == 2 ? "mulai sekarang" : "lanjut",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "PoppinsBold",
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  if (currentpage == 0) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => const LoginTwo()));
                  }
                  // print("lewati");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        currentpage != 2 ? "lewati" : " ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            fontSize: 14,
                            color: Color(0x50000000)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
