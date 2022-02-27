class CategoryProductModel {
  List<Data>? data;

  CategoryProductModel({this.data});

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
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
  String? body;
  String? brand;
  String? price;
  String? condition;
  List<Images>? images;

  Data(
      {this.id,
      this.authorId,
      this.author,
      this.authorImg,
      this.category,
      this.categoryId,
      this.title,
      this.productCity,
      this.body,
      this.brand,
      this.condition,
      this.price,
      this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorId = json['author_id'];
    author = json['author'];
    authorImg = json['author_img'];
    category = json['category'];
    categoryId = json['category_id'];
    title = json['title'];
    productCity = json['product_city'];
    body = json['body'];
    price = json['price'];
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

  Images({this.id, this.productId, this.url, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
