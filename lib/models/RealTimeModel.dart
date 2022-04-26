class RealTimeModel {
  int? id;
  String? body;
  bool? read;
  int? userId;
  int? conversationId;
  String? createdAt;
  RealTimeModel(
      {this.id,
      this.body,
      this.read,
      this.userId,
      this.conversationId,
      this.createdAt});
  factory RealTimeModel.fromJson(dynamic json) {
    return RealTimeModel(
      id: json['id'],
      body: json['body'],
      read: json['read'],
      userId: json['user_id'],
      conversationId: json['conversation_id'],
      createdAt: json['created_at'],
    );
  }
}
