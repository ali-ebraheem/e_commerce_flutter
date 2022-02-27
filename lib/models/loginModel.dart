class LoginModel {
  late String token;
  late UserLoginModel user;
  LoginModel.fromMap(Map<String, dynamic> json) {
    token = json['data']['access_token'];
    user = UserLoginModel.fromMap(json['data']['user']);
  }
}

class UserLoginModel {
  int? id;
  late String name;
  late String email;
  late String role;
  late String city;
  late String image;

  UserLoginModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['picture'];
    city = json['city'];
    role = json['role'];
  }
}
