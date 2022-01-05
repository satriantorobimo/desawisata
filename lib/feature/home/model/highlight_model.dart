class HighlightModel {
  bool status;
  List<Data> data;

  HighlightModel({this.status, this.data});

  HighlightModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String title;
  String shortContent;
  String villageName;
  Ratings ratings;
  String locationName;
  String sourceImage;
  List<Categories> categories;

  Data(
      {this.id,
      this.title,
      this.shortContent,
      this.villageName,
      this.ratings,
      this.locationName,
      this.sourceImage,
      this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortContent = json['short_content'];
    villageName = json['village_name'];
    ratings =
        json['ratings'] != null ? new Ratings.fromJson(json['ratings']) : null;
    locationName = json['location_name'];
    sourceImage = json['source_image'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short_content'] = this.shortContent;
    data['village_name'] = this.villageName;
    if (this.ratings != null) {
      data['ratings'] = this.ratings.toJson();
    }
    data['location_name'] = this.locationName;
    data['source_image'] = this.sourceImage;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ratings {
  String point;
  int total;

  Ratings({this.point, this.total});

  Ratings.fromJson(Map<String, dynamic> json) {
    point = json['point'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['point'] = this.point;
    data['total'] = this.total;
    return data;
  }
}

class Categories {
  int id;
  String name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
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
