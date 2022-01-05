class PerKabModel {
  bool status;
  List<Data> data;

  PerKabModel({this.status, this.data});

  PerKabModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
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
  String namaProv;
  String namaKab;
  int total;
  String sourceImage;

  Data({this.id, this.namaProv, this.namaKab, this.total, this.sourceImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaProv = json['nama_prov'];
    namaKab = json['nama_kab'];
    total = json['total'];
    sourceImage = json['source_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_prov'] = this.namaProv;
    data['nama_kab'] = this.namaKab;
    data['total'] = this.total;
    data['source_image'] = this.sourceImage;
    return data;
  }
}
