class ReviewModel {
  List<Items> items;
  Pagination pagination;

  ReviewModel({this.items, this.pagination});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  String review;
  String rating;
  CreatedAt createdAt;
  List<String> sourceImages;
  Creator creator;
  Replied replied;

  Items(
      {this.id,
      this.title,
      this.review,
      this.rating,
      this.createdAt,
      this.sourceImages,
      this.creator,
      this.replied});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    review = json['review'];
    rating = json['rating'];
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
    sourceImages = json['source_images'].cast<String>();
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    replied =
        json['replied'] != null ? new Replied.fromJson(json['replied']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['review'] = this.review;
    data['rating'] = this.rating;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
    data['source_images'] = this.sourceImages;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    if (this.replied != null) {
      data['replied'] = this.replied.toJson();
    }
    return data;
  }
}

class CreatedAt {
  String createdAt;
  String createdAtReadable;

  CreatedAt({this.createdAt, this.createdAtReadable});

  CreatedAt.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    createdAtReadable = json['created_at_readable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['created_at_readable'] = this.createdAtReadable;
    return data;
  }
}

class Creator {
  int id;
  String name;
  String sourceAvatar;

  Creator({this.id, this.name, this.sourceAvatar});

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sourceAvatar = json['source_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['source_avatar'] = this.sourceAvatar;
    return data;
  }
}

class Replied {
  String review;
  RepliedAt repliedAt;
  Creators creator;

  Replied({this.review, this.repliedAt, this.creator});

  Replied.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    repliedAt = json['replied_at'] != null
        ? new RepliedAt.fromJson(json['replied_at'])
        : null;
    creator =
        json['creator'] != null ? new Creators.fromJson(json['creator']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review'] = this.review;
    if (this.repliedAt != null) {
      data['replied_at'] = this.repliedAt.toJson();
    }
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    return data;
  }
}

class RepliedAt {
  String repliedAt;
  String repliedAtReadable;

  RepliedAt({this.repliedAt, this.repliedAtReadable});

  RepliedAt.fromJson(Map<String, dynamic> json) {
    repliedAt = json['replied_at'];
    repliedAtReadable = json['replied_at_readable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replied_at'] = this.repliedAt;
    data['replied_at_readable'] = this.repliedAtReadable;
    return data;
  }
}

class Creators {
  Creator data;

  Creators({this.data});

  Creators.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Creator.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['size'] = this.size;
    data['page'] = this.page;
    data['lastPage'] = this.lastPage;
    data['endIndex'] = this.endIndex;
    return data;
  }
}
