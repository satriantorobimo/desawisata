class SubmitReviewModel {
  bool status;
  String message;
  Data data;

  SubmitReviewModel({this.status, this.message, this.data});

  SubmitReviewModel.fromJson(Map<String, dynamic> json) {
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
  String rateableId;
  String rating;
  String title;
  String review;
  String rateableType;
  String ownerId;
  int customerId;
  String visitDate;

  Data(
      {this.rateableId,
      this.rating,
      this.title,
      this.review,
      this.rateableType,
      this.ownerId,
      this.customerId,
      this.visitDate});

  Data.fromJson(Map<String, dynamic> json) {
    rateableId = json['rateable_id'];
    rating = json['rating'];
    title = json['title'];
    review = json['review'];
    rateableType = json['rateable_type'];
    ownerId = json['owner_id'];
    customerId = json['customer_id'];
    visitDate = json['visit_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rateable_id'] = this.rateableId;
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['review'] = this.review;
    data['rateable_type'] = this.rateableType;
    data['owner_id'] = this.ownerId;
    data['customer_id'] = this.customerId;
    data['visit_date'] = this.visitDate;
    return data;
  }
}
