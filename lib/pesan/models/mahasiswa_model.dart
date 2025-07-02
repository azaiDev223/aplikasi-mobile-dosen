import 'dart:convert';

class Mahasiswa {
    final int id;
    final String nim;
    final String nama;
    final String? foto;

    Mahasiswa({
        required this.id,
        required this.nim,
        required this.nama,
        this.foto,
    });

    factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
        id: json["id"],
        nim: json["nim"],
        nama: json["nama"],
        foto: json["foto"],
    );
}