import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MahasiswaBimbingan extends StatefulWidget {
  const MahasiswaBimbingan({super.key});

  @override
  State<MahasiswaBimbingan> createState() => _MahasiswaBimbinganState();
}

class _MahasiswaBimbinganState extends State<MahasiswaBimbingan> {
  List<dynamic> bimbinganList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBimbingan();
  }

  // edit status
  Future<void> updateStatus(int bimbinganId, String newStatus) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('http://192.168.112.140:8000/api/bimbingan/$bimbinganId'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'status': newStatus}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Status berhasil diperbarui")),
      );
      fetchBimbingan(); // refresh data
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal mengubah status")),
      );
    }
  }

  void showStatusDialog(int bimbinganId, String currentStatus) {
    final statusOptions = getStatusOptions(currentStatus);

    if (statusOptions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Status ini tidak bisa diubah.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        String? selectedStatus = statusOptions.first;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Ubah Status Bimbingan"),
              content: DropdownButtonFormField<String>(
                value: selectedStatus,
                items: statusOptions.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedStatus != null) {
                      updateStatus(bimbinganId, selectedStatus!);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<String> getStatusOptions(String currentStatus) {
    switch (currentStatus) {
      case 'Diajukan':
        return ['Terjadwal', 'Dibatalkan'];
      case 'Terjadwal':
        return ['Selesai', 'Dibatalkan'];
      default:
        return []; // Selesai/Dibatalkan tidak bisa diubah
    }
  }

  // selesai

  Future<void> fetchBimbingan() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('http://192.168.112.140:8000/api/bimbingan-dosen'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        bimbinganList = data['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      debugPrint('Gagal mengambil data bimbingan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Bimbingan Mahasiswa",
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bimbinganList.isEmpty
              ? const Center(child: Text("Belum ada data bimbingan."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: bimbinganList.length,
                  itemBuilder: (context, index) {
                    final item = bimbinganList[index];
                    return Card(
                      color: Colors.orange[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildRow("Nama", item['mahasiswa']['nama']),
                            buildRow("NIM",
                                item['mahasiswa']['nim']?.toString() ?? '-'),
                            buildRow(
                                "Angkatan",
                                item['mahasiswa']['angkatan']?.toString() ??
                                    '-'),
                            buildRow("Topik", item['topik']),
                            buildRow("Tanggal", item['tanggal_bimbingan']),
                            buildRow("Status", item['status']),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () {
                                  showStatusDialog(item['id'], item['status']);
                                },
                                child: const Text("Ubah Status",
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget buildRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(value,
                style: const TextStyle(fontSize: 14, color: Colors.white)),
          ],
        ),
        const SizedBox(height: 4),
        const Divider(color: Colors.white, thickness: 1),
      ],
    );
  }
}
