class ConversationModel {
  List<Data>? data;
  ConversationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  User? user;
  LastMessage? lastMessage;
  String? createdAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;
    createdAt = json['created_at'];
  }
}

class User {
  int? id;
  String? name;
  String? picture;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picture = json['picture'];
  }
}

class LastMessage {
  int? id;
  String? body;
  bool? read;
  int? userId;
  int? conversationId;
  String? createdAt;

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    read = json['read'];
    userId = json['user_id'];
    conversationId = json['conversation_id'];
    createdAt = json['created_at'];
  }
}
