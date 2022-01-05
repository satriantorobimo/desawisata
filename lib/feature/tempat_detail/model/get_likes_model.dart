class GetLikesModel {
  bool status;
  Data data;

  GetLikesModel({this.status, this.data});

  GetLikesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  bool isLiked;
  UpdatedAt updatedAt;

  Data({this.isLiked, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    isLiked = json['is_liked'];
    updatedAt = json['updated_at'] != null
        ? new UpdatedAt.fromJson(json['updated_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_liked'] = this.isLiked;
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt.toJson();
    }
    return data;
  }
}

class UpdatedAt {
  String updatedAt;
  String updatedAtReadable;

  UpdatedAt({this.updatedAt, this.updatedAtReadable});

  UpdatedAt.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updated_at'];
    updatedAtReadable = json['updated_at_readable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at'] = this.updatedAt;
    data['updated_at_readable'] = this.updatedAtReadable;
    return data;
  }
}
