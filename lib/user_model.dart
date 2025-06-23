import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier {
  String name;
  String nim;
  String fakultas;
  String prodi;
  String tempatLahir;
  String tanggalLahir;
  String alamat;

  UserModel({
    required this.name,
    required this.nim,
    required this.fakultas,
    required this.prodi,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.alamat,
  });

  void updateUser({
    required String name,
    required String nim,
    required String fakultas,
    required String prodi,
    required String tempatLahir,
    required String tanggalLahir,
    required String alamat,
  }) {
    this.name = name;
    this.nim = nim;
    this.fakultas = fakultas;
    this.prodi = prodi;
    this.tempatLahir = tempatLahir;
    this.tanggalLahir = tanggalLahir;
    this.alamat = alamat;
    notifyListeners(); // Notify listeners to rebuild UI
  }
}
