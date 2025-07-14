import 'dart:convert';
import 'dart:io';
import 'package:aplikasi_dosen/login%20dan%20register/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final cNip = TextEditingController();
  final cNama = TextEditingController();
  final cEmail = TextEditingController();
  final cPass = TextEditingController();
  final cConfirmPass = TextEditingController();
  final cHp = TextEditingController();
  final cTgl = TextEditingController();

  List<dynamic> prodiList = [];
  int? selectedProdi;
  String? selectedGender;
  String errorMsg = '';
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    fetchProdi();
  }

  Future<void> fetchProdi() async {
    final res = await http.get(
      Uri.parse('http://192.168.112.140:8000/api/prodi'),
      headers: {'Accept': 'application/json'},
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setState(() => prodiList = data['data'] ?? []);
    }
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  Future<void> registerDosen() async {
    if (!_formKey.currentState!.validate()) return;
    if (cPass.text != cConfirmPass.text) {
      setState(() => errorMsg = 'Password tidak cocok');
      return;
    }

    setState(() => errorMsg = '');

    try {
      var uri = Uri.parse('http://192.168.112.140:8000/api/dosen');
      var request = http.MultipartRequest('POST', uri);

      request.fields['nip'] = cNip.text.trim();
      request.fields['nama'] = cNama.text.trim();
      request.fields['email'] = cEmail.text.trim();
      request.fields['password'] = cPass.text.trim();
      request.fields['jenis_kelamin'] = selectedGender ?? '';
      request.fields['no_hp'] = cHp.text.trim();
      request.fields['tanggal_lahir'] = cTgl.text.trim();
      request.fields['program_studi_id'] = selectedProdi.toString();

      if (_selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'foto',
          _selectedImage!.path,
        ));
      }

      request.headers['Accept'] = 'application/json';

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi berhasil')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginTwo()),
        );
      } else {
        final json = jsonDecode(responseBody);
        setState(() => errorMsg = json['message'] ?? 'Gagal registrasi');
      }
    } catch (e) {
      setState(() => errorMsg = 'Terjadi kesalahan: $e');
    }
  }

  Widget buildInput(String label, TextEditingController c,
      {bool pass = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        controller: c,
        obscureText: pass,
        validator: (v) => v == null || v.isEmpty ? '$label harus diisi' : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
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
          Padding(
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
                    'Register',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'PoppinsEkstraBold',
                      color: Color(0xFF00712D),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : null,
                            child: _selectedImage == null
                                ? const Icon(Icons.camera_alt, size: 40)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("Klik gambar untuk pilih foto"),
                        if (errorMsg.isNotEmpty)
                          Text(errorMsg,
                              style: const TextStyle(color: Colors.red)),
                        buildInput('NIP', cNip),
                        buildInput('Nama', cNama),
                        buildInput('Email', cEmail),
                        buildInput('Password', cPass, pass: true),
                        buildInput('Konfirmasi Password', cConfirmPass,
                            pass: true),
                        buildInput('No HP', cHp),
                        buildInput('Tanggal Lahir (YYYY-MM-DD)', cTgl),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Jenis Kelamin',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'Laki-laki', child: Text('Laki-laki')),
                            DropdownMenuItem(
                                value: 'Perempuan', child: Text('Perempuan')),
                          ],
                          onChanged: (v) => setState(() => selectedGender = v),
                          validator: (v) =>
                              v == null ? 'Pilih jenis kelamin' : null,
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: 'Program Studi',
                            border: OutlineInputBorder(),
                          ),
                          items: prodiList
                              .map<DropdownMenuItem<int>>(
                                  (p) => DropdownMenuItem<int>(
                                        value: p['id'],
                                        child: Text(p['nama_prodi']),
                                      ))
                              .toList(),
                          value: selectedProdi,
                          onChanged: (v) => setState(() => selectedProdi = v),
                          validator: (v) =>
                              v == null ? 'Pilih Program Studi' : null,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: registerDosen,
                          child: const Text('Register'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF9100),
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Kembali ke Login',
                            style: TextStyle(fontFamily: 'PoppinsMedium'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
