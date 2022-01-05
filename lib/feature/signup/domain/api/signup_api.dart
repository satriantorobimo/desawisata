import 'dart:convert';
import 'dart:developer';

import 'package:desa_wisata_nusantara/feature/signup/model/google_signin_model.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/signup_model.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/signup_request_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';

class SignupApi {
  SignupModel signupModel;
  GoogleSignupModel googleSignupModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<SignupModel> attemptRegister(
      SignupRequestModel signupRequestModel) async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();
    final Map mapData = {};
    mapData["email"] = signupRequestModel.email;
    mapData["name"] = signupRequestModel.name;
    mapData["password"] = signupRequestModel.password;
    final String _json = jsonEncode(mapData);
    log('$_json');
    return await netUtil
        .post(urlString.getUrlRegister(), headers: header, body: _json)
        .then((dynamic res) {
      signupModel = SignupModel.fromJson(res);
      return signupModel;
    });
  }

  Future<GoogleSignupModel> attemptRegisterGoogle(String token) async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlRegisterGoogle(token), headers: header)
        .then((dynamic res) {
      googleSignupModel = GoogleSignupModel.fromJson(res);
      return googleSignupModel;
    });
  }

  Future<GoogleSignupModel> attemptRegisterFacebook(String token) async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlRegisterFb(token), headers: header)
        .then((dynamic res) {
      googleSignupModel = GoogleSignupModel.fromJson(res);
      return googleSignupModel;
    });
  }
}
