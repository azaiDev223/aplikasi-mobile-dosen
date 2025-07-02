class Dosen {
  final int id;
  final String nama;
  final String email;
  final String nip;

  Dosen({required this.id, required this.nama, required this.email, required this.nip});

  factory Dosen.fromJson(Map<String, dynamic> json) {
    return Dosen(
      id: int.parse(json['id'].toString()),
      nama: json['nama'],
      email: json['email'],
      nip: json['nip'],
    );
  }
}
