import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MahasiswaNilaiPage extends StatefulWidget {
  final int jadwalKuliahId;
  final int mataKuliahId;

  const MahasiswaNilaiPage({
    super.key,
    required this.jadwalKuliahId,
    required this.mataKuliahId,
  });

  @override
  State<MahasiswaNilaiPage> createState() => _MahasiswaNilaiPageState();
}

class _MahasiswaNilaiPageState extends State<MahasiswaNilaiPage> {
  List<dynamic> mahasiswaList = [];
  Map<int, TextEditingController> nilaiControllers = {};
  Map<int, TextEditingController> gradeControllers = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMahasiswa(widget.jadwalKuliahId);
  }

  Future<void> fetchMahasiswa(int jadwalId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(
          'http://192.168.112.140:8000/api/input-nilai/mahasiswa/$jadwalId?mata_kuliah_id=${widget.mataKuliahId}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        mahasiswaList = data;
        for (var mhs in data) {
          nilaiControllers[mhs['id']] = TextEditingController();
          gradeControllers[mhs['id']] = TextEditingController();
        }
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      print('Gagal ambil mahasiswa: ${response.body}');
    }
  }

  Future<void> simpanNilai(
    int mahasiswaId,
    String nilai,
    String grade,
    int semester,
    String tahunAkademik,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('http://192.168.112.140:8000/api/input-nilai/simpan'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'mahasiswa_id': mahasiswaId,
        'semester': semester,
        'tahun_akademik': tahunAkademik,
        'mata_kuliah_id': widget.mataKuliahId,
        'nilai': double.tryParse(nilai),
        'grade': grade,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nilai berhasil disimpan')),
      );
      fetchMahasiswa(widget.jadwalKuliahId); // Refresh list setelah simpan
    } else {
      print('Gagal simpan nilai: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan nilai')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Input Nilai Mahasiswa',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'PoppinsMedium',
          ),
        ),
        backgroundColor: const Color(0xFF00712D),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MahasiswaSudahDinilaiPage(
                    jadwalKuliahId: widget.jadwalKuliahId,
                    mataKuliahId: widget.mataKuliahId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : mahasiswaList.isEmpty
              ? const Center(child: Text('Tidak ada mahasiswa.'))
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: mahasiswaList.length,
                  itemBuilder: (context, index) {
                    final mhs = mahasiswaList[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mhs['nama'] ?? 'Nama tidak tersedia',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PoppinsMedium',
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Semester: ${mhs['semester']}  |  Tahun: ${mhs['tahun_akademik']}',
                              style: const TextStyle(
                                fontFamily: 'PoppinsRegular',
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: nilaiControllers[mhs['id']],
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: const InputDecoration(
                                      labelText: 'Nilai',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: gradeControllers[mhs['id']],
                                    decoration: const InputDecoration(
                                      labelText: 'Grade',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00712D),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  simpanNilai(
                                    mhs['id'],
                                    nilaiControllers[mhs['id']]!.text,
                                    gradeControllers[mhs['id']]!.text,
                                    mhs['semester'],
                                    mhs['tahun_akademik'],
                                  );
                                },
                                icon: const Icon(Icons.save, size: 18),
                                label: const Text('Simpan',
                                    style: TextStyle(
                                        fontFamily: 'PoppinsRegular')),
                              ),
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

class MahasiswaSudahDinilaiPage extends StatelessWidget {
  final int jadwalKuliahId;
  final int mataKuliahId;

  const MahasiswaSudahDinilaiPage({
    super.key,
    required this.jadwalKuliahId,
    required this.mataKuliahId,
  });

  Future<List<dynamic>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(
          'http://192.168.112.140:8000/api/input-nilai/sudah-dinilai/$jadwalKuliahId?mata_kuliah_id=$mataKuliahId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sudah Dinilai',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'PoppinsMedium',
          ),
        ),
        backgroundColor: const Color(0xFF00712D),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Belum ada mahasiswa yang dinilai.'));
          }

          final mahasiswaList = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: mahasiswaList.length,
            itemBuilder: (context, index) {
              final mhs = mahasiswaList[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    mhs['nama'] ?? '-',
                    style: const TextStyle(
                      fontFamily: 'PoppinsMedium',
                    ),
                  ),
                  subtitle: Text(
                    'Nilai: ${mhs['nilai']}   •   Grade: ${mhs['grade']}',
                    style: const TextStyle(fontFamily: 'PoppinsRegular'),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.grey),
                    // onPressed: () {
                    //   // Fitur edit bisa ditambahkan di sini
                    // },
                    onPressed: () {
                      final nilaiController =
                          TextEditingController(text: mhs['nilai'].toString());
                      final gradeController =
                          TextEditingController(text: mhs['grade'].toString());

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Edit Nilai'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: nilaiController,
                                decoration:
                                    const InputDecoration(labelText: 'Nilai'),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: gradeController,
                                decoration:
                                    const InputDecoration(labelText: 'Grade'),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                final token = prefs.getString('token');

                                final response = await http.post(
                                  Uri.parse(
                                      'http://192.168.112.140:8000/api/input-nilai/simpan'),
                                  headers: {
                                    'Authorization': 'Bearer $token',
                                    'Accept': 'application/json',
                                    'Content-Type': 'application/json',
                                  },
                                  body: json.encode({
                                    'mahasiswa_id': mhs['id'],
                                    'semester': mhs['semester'],
                                    'tahun_akademik': mhs['tahun_akademik'],
                                    'mata_kuliah_id': mataKuliahId,
                                    'nilai':
                                        double.tryParse(nilaiController.text),
                                    'grade': gradeController.text,
                                  }),
                                );

                                if (response.statusCode == 200) {
                                  Navigator.pop(context, true); // Tutup dialog
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Nilai berhasil diperbarui')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Gagal mengupdate nilai')),
                                  );
                                }
                              },
                              child: const Text('Simpan'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
