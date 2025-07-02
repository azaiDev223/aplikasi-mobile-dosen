import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditAkun extends StatefulWidget {
  const EditAkun({super.key});

  @override
  State<EditAkun> createState() => _EditAkunState();
}

class _EditAkunState extends State<EditAkun> {
  TextEditingController namaController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  String? programStudi;
  String? fotoUrl;

  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchDataDiri();
  }

  Future<void> fetchDataDiri() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final res = await http.get(
      Uri.parse('http://192.168.131.140:8000/api/dosen/me'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final data = json['data'];

      setState(() {
        namaController.text = data['nama'] ?? '';
        nipController.text = data['nip'] ?? '';
        emailController.text = data['email'] ?? '';
        tanggalLahirController.text = data['tanggal_lahir'] ?? '';
        jenisKelaminController.text = data['jenis_kelamin'] ?? '';
        noHpController.text = data['no_hp'] ?? '';
        programStudi = data['program_studi'] ?? '-';
        fotoUrl = data['foto_url'];
      });
    } else {
      debugPrint("❌ Gagal memuat data diri dosen. Status: ${res.statusCode}");
      debugPrint(res.body);
    }
  }

  Future<void> updateDataDiri() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.131.140:8000/api/dosen/profile/update'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    request.fields['_method'] = 'PUT';
    request.fields['nama'] = namaController.text;
    request.fields['nip'] = nipController.text;
    request.fields['email'] = emailController.text;
    request.fields['tanggal_lahir'] = tanggalLahirController.text;
    request.fields['jenis_kelamin'] = jenisKelaminController.text;
    request.fields['no_hp'] = noHpController.text;

    if (_image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('foto', _image!.path));
    }

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      debugPrint("✅ Berhasil update data.");
      final responseData = jsonDecode(body);
      final dosen = responseData['dosen']; // pastikan nama key sesuai response

      // Simpan ke SharedPreferences agar halaman lain ikut terupdate
      await prefs.setString('nama', dosen['nama'] ?? '');
      await prefs.setString('nip', dosen['nip'] ?? '');
      await prefs.setString('email', dosen['email'] ?? '');
      await prefs.setString('jenis_kelamin', dosen['jenis_kelamin'] ?? '');
      await prefs.setString('tanggal_lahir', dosen['tanggal_lahir'] ?? '');
      await prefs.setString('no_hp', dosen['no_hp'] ?? '');
      await prefs.setString('foto_url', dosen['foto_url'] ?? '');
      await prefs.setString('program_studi', dosen['program_studi'] ?? '');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Berhasil memperbarui data")),
        );
        Navigator.pop(context);
      }
    } else {
      debugPrint("❌ Gagal update data. Status: ${response.statusCode}");
      debugPrint("❌ Response body: $body");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal memperbarui data: $body")),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: readOnly ? Colors.grey[300] : Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD9D9D9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(15)),
          child: AppBar(
            backgroundColor: const Color(0xFF00712D),
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: const [
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
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.red, size: 20),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : (fotoUrl != null
                          ? NetworkImage(fotoUrl!) as ImageProvider
                          : const AssetImage("asset/image/profile.png")),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _pickImage,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.orange, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField("Nama", namaController),
          _buildTextField("NIP", nipController),
          _buildTextField("Email", emailController),
          _buildTextField("Tanggal Lahir", tanggalLahirController),
          _buildTextField("Jenis Kelamin", jenisKelaminController),
          _buildTextField("No HP", noHpController),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              readOnly: true,
              controller: TextEditingController(text: programStudi ?? '-'),
              decoration: InputDecoration(
                labelText: "Program Studi",
                filled: true,
                fillColor: Colors.grey[300],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: updateDataDiri,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1400FF),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Simpan Perubahan",
                  style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
