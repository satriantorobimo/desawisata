class TempatDetailModel {
  bool status;
  Data data;

  TempatDetailModel({this.status, this.data});

  TempatDetailModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String title;
  String shortContent;
  String content;
  Ratings ratings;
  int likes;
  String facility;
  String preparation;
  Contacts contacts;
  Locations locations;
  List<Photos> photos;
  Creator creator;
  List<Hours> hours;
  List<Categories> categories;
  CurrentHour currentHour;

  Data(
      {this.id,
      this.title,
      this.shortContent,
      this.content,
      this.ratings,
      this.likes,
      this.facility,
      this.preparation,
      this.contacts,
      this.locations,
      this.photos,
      this.creator,
      this.hours,
      this.categories,
      this.currentHour});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortContent = json['short_content'];
    content = json['content'];
    ratings =
        json['ratings'] != null ? new Ratings.fromJson(json['ratings']) : null;
    likes = json['likes'];
    facility = json['facility'];
    preparation = json['preparation'];
    contacts = json['contacts'] != null
        ? new Contacts.fromJson(json['contacts'])
        : null;
    locations = json['locations'] != null
        ? new Locations.fromJson(json['locations'])
        : null;
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    if (json['hours'] != null) {
      hours = new List<Hours>();
      json['hours'].forEach((v) {
        hours.add(new Hours.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    currentHour = json['current_hour'] != null
        ? new CurrentHour.fromJson(json['current_hour'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short_content'] = this.shortContent;
    data['content'] = this.content;
    if (this.ratings != null) {
      data['ratings'] = this.ratings.toJson();
    }
    data['likes'] = this.likes;
    data['facility'] = this.facility;
    data['preparation'] = this.preparation;
    if (this.contacts != null) {
      data['contacts'] = this.contacts.toJson();
    }
    if (this.locations != null) {
      data['locations'] = this.locations.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    if (this.hours != null) {
      data['hours'] = this.hours.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.currentHour != null) {
      data['current_hour'] = this.currentHour.toJson();
    }
    return data;
  }
}

class Ratings {
  Summaries summaries;
  List<Details> details;

  Ratings({this.summaries, this.details});

  Ratings.fromJson(Map<String, dynamic> json) {
    summaries = json['summaries'] != null
        ? new Summaries.fromJson(json['summaries'])
        : null;
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summaries != null) {
      data['summaries'] = this.summaries.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentHour {
  String day;
  bool isOpen;
  String hour;

  CurrentHour({this.day, this.isOpen, this.hour});

  CurrentHour.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    isOpen = json['is_open'];
    hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['is_open'] = this.isOpen;
    data['hour'] = this.hour;
    return data;
  }
}

class Summaries {
  String point;
  int total;

  Summaries({this.point, this.total});

  Summaries.fromJson(Map<String, dynamic> json) {
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

class Details {
  int id;
  String name;
  int total;

  Details({this.id, this.name, this.total});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total'] = this.total;
    return data;
  }
}

class Contacts {
  String phone;
  String website;
  String twitter;
  String facebook;
  String instagram;

  Contacts(
      {this.phone, this.website, this.twitter, this.facebook, this.instagram});

  Contacts.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    website = json['website'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    instagram = json['instagram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['website'] = this.website;
    data['twitter'] = this.twitter;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    return data;
  }
}

class Locations {
  String villageName;
  String locationName;
  String mileage;
  String travelingTime;
  String roadCondition;
  String transportationAvail;
  String latLng;
  String sourceMap;

  Locations(
      {this.villageName,
      this.locationName,
      this.mileage,
      this.travelingTime,
      this.roadCondition,
      this.transportationAvail,
      this.latLng,
      this.sourceMap});

  Locations.fromJson(Map<String, dynamic> json) {
    villageName = json['village_name'];
    locationName = json['location_name'];
    mileage = json['mileage'];
    travelingTime = json['traveling_time'];
    roadCondition = json['road_condition'];
    transportationAvail = json['transportation_avail'];
    latLng = json['lat_lng'];
    sourceMap = json['source_map'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['village_name'] = this.villageName;
    data['location_name'] = this.locationName;
    data['mileage'] = this.mileage;
    data['traveling_time'] = this.travelingTime;
    data['road_condition'] = this.roadCondition;
    data['transportation_avail'] = this.transportationAvail;
    data['lat_lng'] = this.latLng;
    data['source_map'] = this.sourceMap;
    return data;
  }
}

class Photos {
  int id;
  String sourceImage;
  String description;
  CreatedAt createdAt;

  Photos({this.id, this.sourceImage, this.description, this.createdAt});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sourceImage = json['source_image'];
    description = json['description'];
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['source_image'] = this.sourceImage;
    data['description'] = this.description;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
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

class Hours {
  String day;
  bool isOpen;
  String hour;

  Hours({this.day, this.isOpen, this.hour});

  Hours.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    isOpen = json['is_open'];
    hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['is_open'] = this.isOpen;
    data['hour'] = this.hour;
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
