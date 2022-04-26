class FavoriteModel {
  List<Data>? data;

  FavoriteModel({this.data});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
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
  int? authorId;
  String? author;
  String? authorImg;
  String? category;
  int? categoryId;
  String? title;
  String? productCity;
  String? price;
  String? body;
  String? brand;
  String? condition;
  List<Images>? images;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorId = json['author_id'];
    author = json['author'];
    authorImg = json['author_img'];
    category = json['category'];
    categoryId = json['category_id'];
    title = json['title'];
    productCity = json['product_city'];
    price = json['price'];
    body = json['body'];
    brand = json['brand'];
    condition = json['condition'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }
}

class Images {
  int? id;
  int? productId;
  String? url;
  String? createdAt;
  String? updatedAt;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
