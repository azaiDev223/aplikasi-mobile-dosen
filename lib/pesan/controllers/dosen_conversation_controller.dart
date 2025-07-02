import 'package:aplikasi_dosen/pesan/api/api_service.dart';
import 'package:aplikasi_dosen/pesan/controllers/auth_dosen_controller.dart';
import 'package:aplikasi_dosen/pesan/models/mahasiswa_model.dart';
import 'package:get/get.dart';




class DosenConversationController extends GetxController {
  final ApiService _apiService = ApiService();
  final AuthDosenController _authController = Get.find(); // Pastikan Anda punya controller ini

  var conversationList = <Mahasiswa>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchConversations();
  }

  Future<void> fetchConversations() async {
    try {
      isLoading.value = true;
      final token = _authController.token.value; // Ambil token dosen
      final result = await _apiService.getDosenConversations(token);
      conversationList.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat daftar mahasiswa: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
