class SubmitQuestionModel {
  bool status;
  String message;
  Data data;

  SubmitQuestionModel({this.status, this.message, this.data});

  SubmitQuestionModel.fromJson(Map<String, dynamic> json) {
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
  String questionText;
  int createdBy;

  Data({this.produkWisataId, this.questionText, this.createdBy});

  Data.fromJson(Map<String, dynamic> json) {
    produkWisataId = json['produk_wisata_id'];
    questionText = json['question_text'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produk_wisata_id'] = this.produkWisataId;
    data['question_text'] = this.questionText;
    data['created_by'] = this.createdBy;
    return data;
  }
}
