class ListCategoryModel {
  List<Items> items;
  Pagination pagination;

  ListCategoryModel({this.items, this.pagination});

  ListCategoryModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String title;
  String shortContent;
  String villageName;
  Null likes;
  Ratings ratings;
  String locationName;
  String sourceImage;
  List<Categories> categories;

  Items(
      {this.id,
      this.title,
      this.shortContent,
      this.villageName,
      this.likes,
      this.ratings,
      this.locationName,
      this.sourceImage,
      this.categories});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortContent = json['short_content'];
    villageName = json['village_name'];
    likes = json['likes'];
    ratings =
        json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null;
    locationName = json['location_name'];
    sourceImage = json['source_image'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short_content'] = this.shortContent;
    data['village_name'] = this.villageName;
    data['likes'] = this.likes;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
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
