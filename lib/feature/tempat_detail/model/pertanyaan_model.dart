class PertanyaanModel {
  List<Items> items;
  Pagination pagination;

  PertanyaanModel({this.items, this.pagination});

  PertanyaanModel.fromJson(Map<String, dynamic> json) {
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
  String question;
  CreatedAt createdAt;
  Creator creator;
  Replied replied;

  Items({this.id, this.question, this.createdAt, this.creator, this.replied});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    createdAt = json['created_at'] != null
        ? CreatedAt.fromJson(json['created_at'])
        : null;
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    replied =
        json['replied'] != null ? Replied.fromJson(json['replied']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['source_avatar'] = this.sourceAvatar;
    return data;
  }
}

class Replied {
  String answerText;
  RepliedAt repliedAt;
  Creator creator;

  Replied({this.answerText, this.repliedAt, this.creator});

  Replied.fromJson(Map<String, dynamic> json) {
    answerText = json['answer_text'];
    repliedAt = json['replied_at'] != null
        ? RepliedAt.fromJson(json['replied_at'])
        : null;
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['answer_text'] = this.answerText;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['replied_at'] = this.repliedAt;
    data['replied_at_readable'] = this.repliedAtReadable;
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
