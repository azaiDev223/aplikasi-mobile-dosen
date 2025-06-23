import 'package:aplikasi_dosen/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAkun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    // Controllers untuk setiap input
    TextEditingController nameController =
        TextEditingController(text: user.name);
    TextEditingController nimController = TextEditingController(text: user.nim);
    TextEditingController fakultasController =
        TextEditingController(text: user.fakultas);
    TextEditingController prodiController =
        TextEditingController(text: user.prodi);
    TextEditingController tempatLahirController =
        TextEditingController(text: user.tempatLahir);
    TextEditingController tanggalLahirController =
        TextEditingController(text: user.tanggalLahir);
    TextEditingController alamatController =
        TextEditingController(text: user.alamat);

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
                      "Edit Akun",
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
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "< Kembali",
                    style: TextStyle(
                        fontFamily: 'PoppinsBold',
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 167,
                        height: 167,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: AssetImage('asset/image/profile.png'),
                            fit: BoxFit.cover,
                          ),
                          border:
                              Border.all(color: Color(0xFFFF9100), width: 5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Positioned(
                        bottom: -20,
                        child: ElevatedButton(
                          onPressed: () {
                            // Aksi untuk mengedit foto
                          },
                          child: const Icon(Icons.add_a_photo_rounded),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(5),
                            minimumSize: Size(104, 104),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Form untuk mengedit data
            Column(
              children: [
                _buildTextField("Nama", nameController),
                _buildTextField("NIM", nimController),
                _buildTextField("Fakultas", fakultasController),
                _buildTextField("Prodi", prodiController),
                _buildTextField("Tempat Lahir", tempatLahirController),
                _buildTextField("Tanggal Lahir", tanggalLahirController),
                _buildTextField("Alamat", alamatController),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white.withOpacity(0.30),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // Simpan data ke Provider
              user.updateUser(
                name: nameController.text,
                nim: nimController.text,
                fakultas: fakultasController.text,
                prodi: prodiController.text,
                tempatLahir: tempatLahirController.text,
                tanggalLahir: tanggalLahirController.text,
                alamat: alamatController.text,
              );

              // Menampilkan dialog setelah data disimpan
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff1400FF),
                        ),
                        child: const Center(
                          child: Text(
                            'Oke',
                            style: TextStyle(
                              fontFamily: 'Poppinsmedium',
                              fontSize: 14,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  title: const Text(
                    "Data Diri berhasil diubah",
                    style: TextStyle(fontFamily: 'Poppinsmedium', fontSize: 20),
                  ),
                  contentPadding: const EdgeInsets.all(30),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'asset/image/beenhere.png',
                        width: 71,
                        height: 71,
                      )
                    ],
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff1400FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              minimumSize: Size(double.infinity, 65),
            ),
            child: Center(
              child: Text(
                "Simpan",
                style: TextStyle(
                  fontFamily: 'Poppinsmedium',
                  fontSize: 14,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppinsmedium',
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
              color: Colors.white,
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                hintText: label,
                hintStyle:
                    TextStyle(fontFamily: 'Poppinssemibold', fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
