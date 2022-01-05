class GoogleSignupModel {
  bool status;
  String message;
  String accessToken;
  Data data;
  int expiresIn;

  GoogleSignupModel(
      {this.status, this.message, this.accessToken, this.data, this.expiresIn});

  GoogleSignupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['expires_in'] = this.expiresIn;
    return data;
  }
}

class Data {
  int id;
  String username;
  String name;
  String email;
  Role role;

  Data({this.id, this.username, this.name, this.email, this.role});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.role != null) {
      data['role'] = this.role.toJson();
    }
    return data;
  }
}

class Role {
  int id;
  String name;

  Role({this.id, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
