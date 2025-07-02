import 'dart:convert';
import 'package:aplikasi_dosen/homepage/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import '../homescreen.dart';
import 'register.dart';

class LoginTwo extends StatefulWidget {
  const LoginTwo({super.key});

  @override
  State<LoginTwo> createState() => _LoginTwoState();
}

class _LoginTwoState extends State<LoginTwo> {
  final formKey = GlobalKey<FormState>();
  final cUser = TextEditingController();
  final cPass = TextEditingController();
  bool isLoading = false;

  Future<void> loginDosen() async {
    setState(() => isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('http://192.168.131.140:8000/api/login-dosen'),
        headers: {'Accept': 'application/json'},
        body: {
          'email': cUser.text.trim(),
          'password': cPass.text.trim(),
        },
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = body['token'];
        final dosen = body['dosen'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token ?? '');
        await prefs.setString('id', dosen['id']?.toString() ?? '');
        await prefs.setString('nama', dosen['nama'] ?? '');
        await prefs.setString('nip', dosen['nip'] ?? '');
        await prefs.setString('email', dosen['email'] ?? '');
        await prefs.setString('foto_url', dosen['foto_url'] ?? '');
        await prefs.setString('jenis_kelamin', dosen['jenis_kelamin'] ?? '');
        await prefs.setString('no_hp', dosen['no_hp'] ?? '');
        await prefs.setString('tanggal_lahir', dosen['tanggal_lahir'] ?? '');
        await prefs.setString(
            'program_studi', dosen['program_studi']?.toString() ?? '');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login berhasil')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const homepage()),
        );
      } else {
        final msg = body['message'] ?? 'Login gagal';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg)));
      }
    } catch (e) {
      debugPrint('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan saat login')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget buildInputField(String label, TextEditingController controller,
      IconData icon, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: (value) =>
            value == null || value.isEmpty ? '$label wajib diisi' : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF00712D)),
          labelText: label,
          filled: true,
          fillColor: const Color(0x20005A24),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF00712D),
            height: double.infinity,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Image(
                    image: AssetImage('asset/image/logo1.png'),
                    width: 59,
                    height: 77,
                  ),
                  Text(
                    'Sistem Akademik',
                    style: TextStyle(
                      fontFamily: 'PoppinsEkstraBold',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFBE6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'PoppinsEkstraBold',
                        color: Color(0xFF00712D),
                      ),
                    ),
                    buildInputField('Email', cUser, Icons.person, false),
                    buildInputField('Password', cPass, Icons.lock, true),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                loginDosen();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9100),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'PoppinsMedium',
                              ),
                            ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Register(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9100),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsMedium',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
