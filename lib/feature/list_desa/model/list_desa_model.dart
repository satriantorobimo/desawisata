class ListDesaModel {
  List<Items> items;
  Pagination pagination;

  ListDesaModel({this.items, this.pagination});

  ListDesaModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
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
  String namaProv;
  String namaKab;
  String villageName;
  String description;
  String locationName;
  int totalWisata;
  String sourceImage;

  Items(
      {this.id,
      this.namaProv,
      this.namaKab,
      this.villageName,
      this.description,
      this.locationName,
      this.totalWisata,
      this.sourceImage});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaProv = json['nama_prov'];
    namaKab = json['nama_kab'];
    villageName = json['village_name'];
    description = json['description'];
    locationName = json['location_name'];
    totalWisata = json['total_wisata'];
    sourceImage = json['source_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_prov'] = this.namaProv;
    data['nama_kab'] = this.namaKab;
    data['village_name'] = this.villageName;
    data['description'] = this.description;
    data['location_name'] = this.locationName;
    data['total_wisata'] = this.totalWisata;
    data['source_image'] = this.sourceImage;
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
