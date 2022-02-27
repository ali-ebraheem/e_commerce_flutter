class CommentModel {
  List<Data>? data;

  CommentModel.fromJson(List<dynamic> json) {
    if (json != null) {
      data = [];
      json.forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  int? userId;
  int? productId;
  String? body;
  String? createdAt;
  String? updatedAt;
  Author? author;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
  }
}

class Author {
  int? id;
  String? name;
  String? email;
  String? role;
  String? city;
  String? picture;

  String? phone;
  String? createdAt;
  String? updatedAt;

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    city = json['city'];
    picture = json['picture'];

    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
