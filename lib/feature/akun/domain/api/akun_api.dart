import 'package:desa_wisata_nusantara/feature/akun/model/akun_model.dart';
import 'package:desa_wisata_nusantara/feature/akun/model/logout_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunApi {
  AkunModel akunModel;
  LogoutModel logoutModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<AkunModel> getAkun() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final Map<String, String> header = urlString.getHeaderTypeWithToken(token);
    return await netUtil
        .get(urlString.getUrlGetAkun(), headers: header)
        .then((dynamic res) {
      akunModel = AkunModel.fromJson(res);
      return akunModel;
    });
  }

  Future<LogoutModel> attemptLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final Map<String, String> header = urlString.getHeaderTypeWithToken(token);
    return await netUtil
        .post(urlString.getUrlLogOut(), headers: header)
        .then((dynamic res) {
      logoutModel = LogoutModel.fromJson(res);
      return logoutModel;
    });
  }
}
