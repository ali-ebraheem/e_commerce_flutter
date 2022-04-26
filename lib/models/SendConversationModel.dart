class SendConversationModel {
  Data? data;

  SendConversationModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? body;
  bool? read;
  int? userId;
  String? conversationId;
  String? createdAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    read = json['read'];
    userId = json['user_id'];
    conversationId = json['conversation_id'];
    createdAt = json['created_at'];
  }
}
