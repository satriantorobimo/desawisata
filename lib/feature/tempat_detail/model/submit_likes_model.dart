class SubmitLikesModel {
  bool status;
  String message;
  Data data;

  SubmitLikesModel({this.status, this.message, this.data});

  SubmitLikesModel.fromJson(Map<String, dynamic> json) {
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
  String produkWisataId;
  bool isLiked;
  String name;

  Data({this.produkWisataId, this.isLiked, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    produkWisataId = json['produk_wisata_id'];
    isLiked = json['is_liked'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produk_wisata_id'] = this.produkWisataId;
    data['is_liked'] = this.isLiked;
    data['name'] = this.name;
    return data;
  }
}
