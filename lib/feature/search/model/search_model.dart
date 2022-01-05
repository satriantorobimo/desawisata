import 'dart:convert';

class SearchModel {
  List<Items> items;
  Pagination pagination;

  SearchModel({this.items, this.pagination});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class Items {
  String id;
  String title;
  String page;
  String subTitle;
  String sourceImage;

  Items({this.id, this.title, this.page, this.subTitle, this.sourceImage});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    page = json['page'];
    subTitle = json['sub_title'];
    sourceImage = json['source_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['page'] = this.page;
    data['sub_title'] = this.subTitle;
    data['source_image'] = this.sourceImage;
    return data;
  }

  static Map<String, dynamic> toMap(Items items) => {
        'id': items.id,
        'title': items.title,
        'page': items.page,
        'sub_title': items.subTitle,
        'source_image': items.sourceImage
      };

  static String encode(List<Items> itemss) => json.encode(
        itemss
            .map<Map<String, dynamic>>((items) => Items.toMap(items))
            .toList(),
      );

  static List<Items> decode(String itemss) =>
      (json.decode(itemss) as List<dynamic>)
          .map<Items>((item) => Items.fromJson(item))
          .toList();
}

class Pagination {
  int length;
  int size;
  int page;
  int lastPage;
  int endIndex;

  Pagination({this.length, this.size, this.page, this.lastPage, this.endIndex});

  Pagination.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    size = json['size'];
    page = json['page'];
    lastPage = json['lastPage'];
    endIndex = json['endIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['length'] = this.length;
    data['size'] = this.size;
    data['page'] = this.page;
    data['lastPage'] = this.lastPage;
    data['endIndex'] = this.endIndex;
    return data;
  }
}
