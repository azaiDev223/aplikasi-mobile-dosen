import 'dart:async';
import 'dart:convert';
import 'package:aplikasi_dosen/pesan/controllers/auth_dosen_controller.dart';
import 'package:aplikasi_dosen/pesan/controllers/dosen_chat_message_controller.dart';
import 'package:aplikasi_dosen/pesan/models/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DosenChatPage extends StatefulWidget {
  final int partnerId;
  final String partnerName;

  const DosenChatPage({
    super.key,
    required this.partnerId,
    required this.partnerName,
  });

  @override
  State<DosenChatPage> createState() => _DosenChatPageState();
}

class _DosenChatPageState extends State<DosenChatPage> {
  late final DosenChatMessageController controller;
  final ScrollController _scrollController = ScrollController();
  late final AuthDosenController authController;
  Timer? autoRefreshTimer;

  @override
  void initState() {
    super.initState();
    authController = Get.find();
    controller = Get.put(
      DosenChatMessageController(mahasiswaId: widget.partnerId),
    );
    controller.messages.listen((_) => _scrollToBottom());

    autoRefreshTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      controller.fetchMessages();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    autoRefreshTimer?.cancel();
    if (Get.isRegistered<DosenChatMessageController>()) {
      Get.delete<DosenChatMessageController>();
    }
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _confirmDeleteMessage(ChatMessage message) async {
    final bool confirmed = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Pesan'),
        content: const Text('Apakah Anda yakin ingin menghapus pesan ini?'),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Hapus'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed) {
      await _deleteMessage(message.id);
    }
  }

  Future<void> _deleteMessage(int messageId) async {
    final token = authController.token.value;
    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Token tidak tersedia. Silakan login ulang.');
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse('http://192.168.131.140:8000/api/chat/$messageId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        controller.fetchMessages();
        Get.snackbar('Berhasil', 'Pesan berhasil dihapus.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        final json = jsonDecode(response.body);
        Get.snackbar('Gagal', json['error'] ?? 'Gagal menghapus pesan',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan saat menghapus pesan.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int? myId = authController.dosen.value?.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.partnerName,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'PoppinsMedium')),
        backgroundColor: const Color(0xFF00712D),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchMessages,
          ),
        ],
      ),
      body: myId == null
          ? const Center(child: Text("Gagal memuat akun dosen."))
          : Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value &&
                        controller.messages.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.messages.isEmpty) {
                      return const Center(child: Text("Belum ada pesan."));
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        final bool isMe =
                            message.senderType.toLowerCase() == 'dosen' &&
                                message.senderId == myId;

                        return GestureDetector(
                          onLongPress: () {
                            if (isMe) {
                              _confirmDeleteMessage(message);
                            }
                          },
                          child: _buildMessageBubble(message, isMe),
                        );
                      },
                    );
                  }),
                ),
                _buildMessageInput(controller),
              ],
            ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF00712D) : const Color(0xFFECECEC),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft:
                isMe ? const Radius.circular(18) : const Radius.circular(0),
            bottomRight:
                isMe ? const Radius.circular(0) : const Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 2),
            )
          ],
        ),
        constraints: BoxConstraints(maxWidth: Get.width * 0.75),
        child: Text(
          message.message,
          style: TextStyle(
            fontFamily: 'PoppinsRegular',
            color: isMe ? Colors.white : Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput(DosenChatMessageController controller) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: const Color(0xFFF9F9F9),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: controller.messageTextController,
                  decoration: const InputDecoration(
                    hintText: 'Ketik pesan...',
                    border: InputBorder.none,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (_) {
                    if (controller.messageTextController.text
                        .trim()
                        .isNotEmpty) {
                      controller.sendMessage();
                    } else {
                      Get.snackbar('Peringatan', 'Pesan tidak boleh kosong.');
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                if (controller.messageTextController.text.trim().isNotEmpty) {
                  controller.sendMessage();
                } else {
                  Get.snackbar('Peringatan', 'Pesan tidak boleh kosong.');
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF00712D),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
