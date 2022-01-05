import 'dart:developer';

import 'package:desa_wisata_nusantara/feature/list_ulasan/model/my_question_model.dart';
import 'package:desa_wisata_nusantara/feature/list_ulasan/model/my_review_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListUlasanApi {
  MyReviewModel myReviewModel;
  MyQuestionModel myQuestionModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<MyReviewModel> getMyReview(int limit, int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final Map<String, String> header = urlString.getHeaderTypeWithToken(token);

    return await netUtil
        .get(urlString.getUrlMyReview(limit, page), headers: header)
        .then((dynamic res) {
      myReviewModel = MyReviewModel.fromJson(res);
      return myReviewModel;
    });
  }

  Future<MyQuestionModel> getMyQuestion(int limit, int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final Map<String, String> header = urlString.getHeaderTypeWithToken(token);

    return await netUtil
        .get(urlString.getUrlMyQuestion(limit, page), headers: header)
        .then((dynamic res) {
      log('$res');
      myQuestionModel = MyQuestionModel.fromJson(res);
      return myQuestionModel;
    });
  }
}
