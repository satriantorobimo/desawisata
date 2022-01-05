import 'dart:developer';

import 'package:desa_wisata_nusantara/feature/tempat_detail/model/get_likes_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/pertanyaan_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/review_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_likes_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_question_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_review_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/tempat_detail_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempatDetailApi {
  TempatDetailModel tempatDetailModel;
  ReviewModel reviewModel;
  SubmitReviewModel submitReviewModel;
  PertanyaanModel pertanyaanModel;
  SubmitQuestionModel submitQuestionModel;
  GetLikesModel getLikesModel;
  SubmitLikesModel submitLikesModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<TempatDetailModel> getTempatDetail(String id) async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();
    DateTime now = DateTime.now();
    String time = now.hour.toString() + ":" + now.minute.toString();
    return await netUtil
        .get(
            urlString.getUrlTempatDetail(
                id, time, DateFormat('EEEE').format(DateTime.now()).toString()),
            headers: header)
        .then((dynamic res) {
      log('$res');
      tempatDetailModel = TempatDetailModel.fromJson(res);
      return tempatDetailModel;
    });
  }

  Future<ReviewModel> getReview(String id, int limit, int page) async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlReview(id, limit, page), headers: header)
        .then((dynamic res) {
      reviewModel = ReviewModel.fromJson(res);
      return reviewModel;
    });
  }

  Future<PertanyaanModel> getPertanyaan(String id, int limit, int page) async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.urlGetPertanyaan(id, limit, page), headers: header)
        .then((dynamic res) {
      pertanyaanModel = PertanyaanModel.fromJson(res);
      return pertanyaanModel;
    });
  }

  Future<SubmitReviewModel> submitReview(
      String fileName1,
      String fileName2,
      String fileName3,
      String wisataId,
      double ratingPoint,
      String visitedAt,
      String review,
      String title,
      String visitedWith) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    log('$ratingPoint');
    return await netUtil
        .postMultiPart(
            urlString.getUrlSubmitReview(),
            fileName1,
            fileName2,
            fileName3,
            token,
            wisataId,
            ratingPoint.toString(),
            visitedAt,
            review,
            title,
            visitedWith)
        .then((dynamic res) {
      submitReviewModel = SubmitReviewModel.fromJson(res);
      return submitReviewModel;
    });
  }

  Future<SubmitQuestionModel> submitQuestion(String id, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final Map<String, String> header =
        urlString.getHeaderTypeBasicFormWithToken(token);
    final Map mapData = Map<String, dynamic>();
    mapData["wisata_id"] = id;
    mapData["question"] = value;

    return await netUtil
        .postForm(urlString.getUrlSubmitQuestion(),
            headers: header, body: mapData)
        .then((dynamic res) {
      submitQuestionModel = SubmitQuestionModel.fromJson(res);
      return submitQuestionModel;
    });
  }

  Future<GetLikesModel> getLikes(String id, String imei) async {
    final Map<String, String> header = urlString.getHeaderTypeBasicForm();

    return await netUtil
        .get(urlString.getUrlGetLikes(id, imei), headers: header)
        .then((dynamic res) {
      getLikesModel = GetLikesModel.fromJson(res);
      return getLikesModel;
    });
  }

  Future<SubmitLikesModel> submitLikes(
      String id, bool isLiked, String imei) async {
    final Map<String, String> header = urlString.getHeaderTypeBasicForm();
    final Map mapData = Map<String, dynamic>();
    mapData["wisata_id"] = id;
    mapData["is_liked"] = isLiked ? '1' : '0';
    mapData["imei"] = imei;

    return await netUtil
        .postForm(urlString.getUrlSubmitLikes(), headers: header, body: mapData)
        .then((dynamic res) {
      submitLikesModel = SubmitLikesModel.fromJson(res);
      return submitLikesModel;
    });
  }
}
