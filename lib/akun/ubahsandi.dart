import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ubahsandi extends StatefulWidget {
  const ubahsandi({super.key});

  @override
  State<ubahsandi> createState() => _ubahsandiState();
}

class _ubahsandiState extends State<ubahsandi> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> ubahPassword() async {
    final currentPassword = currentPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Konfirmasi password tidak cocok")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('http://192.168.131.140:8000/api/dosen/update-password'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Password berhasil diubah",
            style: TextStyle(fontFamily: 'Poppinsmedium', fontSize: 20),
          ),
          contentPadding: const EdgeInsets.all(30),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Image.asset('asset/image/beenhere.png')],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                color: const Color(0xff1400FF),
                child: const Center(
                  child: Text(
                    "Oke",
                    style: TextStyle(
                      fontFamily: 'Poppinsmedium',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? "Gagal mengubah password")),
      );
    }
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 5),
          child: Text(
            label,
            style: const TextStyle(fontFamily: 'Poppinsmedium', fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFFCCDBBF),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: true,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: InputBorder.none,
              hintText: 'masukkan password',
              prefixIcon: Icon(Icons.lock, color: Color(0xff00712D)),
            ),
          ),
        ),
        const SizedBox(height: 18),
      ],
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
                    "Ubah Password",
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                "< Kembali",
                style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 25),
              ),
            ),
          ),
          const SizedBox(height: 18),
          _buildPasswordField("Password Lama", currentPasswordController),
          _buildPasswordField("Password Baru", newPasswordController),
          _buildPasswordField(
              "Konfirmasi Password Baru", confirmPasswordController),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: ubahPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9100),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(double.infinity, 56),
              ),
              child: const Text(
                'Simpan',
                style: TextStyle(
                  fontFamily: 'Poppinsmedium',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
