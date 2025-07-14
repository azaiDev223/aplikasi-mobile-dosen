import 'package:aplikasi_dosen/pesan/models/dosen_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDosenController extends GetxController {
  var token = ''.obs;
  var dosen = Rxn<Dosen>(); // ⬅️ inilah getter 'dosen'

  @override
  void onInit() {
    super.onInit();
    loadAuthData();
  }

  Future<void> loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token') ?? '';

    final dosenId = prefs.getString('id') ?? '';
    final nama = prefs.getString('nama') ?? '';
    final email = prefs.getString('email') ?? '';
    final nip = prefs.getString('nip') ?? '';

    dosen.value = Dosen(
      id: int.parse(dosenId),
      nama: nama,
      email: email,
      nip: nip,
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    token.value = '';
    dosen.value = null;
  }
}
