class SignupModel {
  bool status;
  String message;
  Data data;

  SignupModel({this.status, this.message, this.data});

  SignupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String email;
  String name;
  String username;
  int roleId;
  int isActive;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.email,
      this.name,
      this.username,
      this.roleId,
      this.isActive,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    username = json['username'];
    roleId = json['role_id'];
    isActive = json['is_active'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['username'] = this.username;
    data['role_id'] = this.roleId;
    data['is_active'] = this.isActive;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
