import 'dart:async';
import 'package:aplikasi_dosen/pesan/controllers/auth_dosen_controller.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_dosen/pesan/api/api_service.dart';
import 'package:aplikasi_dosen/pesan/models/chat_message_model.dart';
import 'package:get/get.dart';



class DosenChatMessageController extends GetxController {
  final int mahasiswaId;
  DosenChatMessageController({required this.mahasiswaId});
  
  final ApiService _apiService = ApiService();
  final AuthDosenController _authController = Get.find();

  var messages = <ChatMessage>[].obs;
  var isLoading = true.obs;
  final messageTextController = TextEditingController();
  Timer? _pollingTimer;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) => fetchMessages(isPolling: true));
  }

  @override
  void onClose() {
    _pollingTimer?.cancel();
    messageTextController.dispose();
    super.onClose();
  }

  Future<void> fetchMessages({bool isPolling = false}) async {
    if (!isPolling) isLoading.value = true;
    try {
      final token = _authController.token.value;
      final result = await _apiService.getMessagesWithMahasiswa(token, mahasiswaId);
      if (result.length != messages.length) {
        messages.value = result;
      }
    } catch (e) {
      if (!isPolling) Get.snackbar('Error', e.toString());
    } finally {
      if (!isPolling) isLoading.value = false;
    }
  }

  Future<void> sendMessage() async {
    if (messageTextController.text.isEmpty) return;
    final messageText = messageTextController.text;
    messageTextController.clear();

    try {
      final token = _authController.token.value;
      final sentMessage = await _apiService.sendMessageToMahasiswa(
        token: token,
        receiverId: mahasiswaId,
        message: messageText,
      );
      messages.add(sentMessage);
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengirim pesan');
      messageTextController.text = messageText;
    }
  }
}