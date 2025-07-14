import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/mahasiswa_model.dart';
import '../models/chat_message_model.dart';

class ApiService {
  final String _baseUrl = "http://192.168.112.140:8000/api"; // Sesuaikan IP Anda

  // ... (fungsi login, logout, dll untuk dosen)

  /// DOSEN: Mengambil daftar mahasiswa bimbingan (daftar percakapan).
  Future<List<Mahasiswa>> getDosenConversations(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/dosen/chat/conversations'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body)['data'];
      return body.map((dynamic item) => Mahasiswa.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat daftar percakapan.');
    }
  }

  /// DOSEN: Mengambil riwayat pesan dengan seorang mahasiswa.
  Future<List<ChatMessage>> getMessagesWithMahasiswa(String token, int mahasiswaId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/dosen/chat/$mahasiswaId'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body)['data'];
      return body.map((dynamic item) => ChatMessage.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat pesan.');
    }
  }

  /// DOSEN: Mengirim pesan ke seorang mahasiswa.
  Future<ChatMessage> sendMessageToMahasiswa({
    required String token,
    required int receiverId,
    required String message,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/dosen/chat'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'receiver_id': receiverId,
        'message': message,
      }),
    );
    if (response.statusCode == 201) {
      return ChatMessage.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Gagal mengirim pesan.');
    }
  }
}