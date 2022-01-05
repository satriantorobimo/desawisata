class ImageIntroModel {
  bool status;
  Data data;

  ImageIntroModel({this.status, this.data});

  ImageIntroModel.fromJson(Map<String, dynamic> json) {
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
  String title;
  String subTitle;
  String sourceImage;

  Data({this.title, this.subTitle, this.sourceImage});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['sub_title'];
    sourceImage = json['source_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['source_image'] = this.sourceImage;
    return data;
  }
}
