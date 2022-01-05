import 'dart:developer';

import 'package:desa_wisata_nusantara/feature/login/model/login_model.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/signup_request_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';

class LoginApi {
  LoginModel loginModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<LoginModel> attemptLogin(SignupRequestModel signupRequestModel) async {
    final Map<String, String> header = urlString.getHeaderTypeBasicForm();
    final Map mapData = Map<String, dynamic>();
    mapData["username"] = signupRequestModel.email;
    mapData["password"] = signupRequestModel.password;

    log('$mapData');

    return await netUtil
        .postForm(urlString.getUrlLogin(), headers: header, body: mapData)
        .then((dynamic res) {
      loginModel = LoginModel.fromJson(res);
      return loginModel;
    });
  }
}
