class MessageConversationModel {
  List<Data1>? data;

  MessageConversationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data1>[];
      json['data'].forEach((v) {
        data!.add(new Data1.fromJson(v));
      });
    }
  }
}

class Data1 {
  int? id;
  String? body;
  bool? read;
  int? userId;
  int? conversationId;
  String? createdAt;

  Data1(
      {this.id,
      this.body,
      this.read,
      this.userId,
      this.conversationId,
      this.createdAt});

  factory Data1.fromJseon(dynamic json) {
    return Data1(
      id: json['id'],
      body: json['body'],
      read: json['read'],
      userId: json['user_id'],
      conversationId: json['conversation_id'],
      createdAt: json['created_at'],
    );
  }
  Data1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    read = json['read'];
    userId = json['user_id'];
    conversationId = json['conversation_id'];
    createdAt = json['created_at'];
  }
}
