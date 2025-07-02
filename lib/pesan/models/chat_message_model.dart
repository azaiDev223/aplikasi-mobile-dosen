class ChatMessage {
  final int id;
  final int senderId;
  final String senderType; // 'Dosen' atau 'Mahasiswa'
  final String message;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderType,
    required this.message,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json["id"],
        senderId: json["sender_id"],
        senderType: json["sender_type"], // harus dari API
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
