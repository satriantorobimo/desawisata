import 'package:desa_wisata_nusantara/feature/home/model/highlight_model.dart';
import 'package:desa_wisata_nusantara/feature/home/model/per_kab_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';

class HighlightApi {
  HighlightModel highlightModel;
  PerKabModel perKabModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<HighlightModel> getHighlightContent() async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlHighlight(), headers: header)
        .then((dynamic res) {
      highlightModel = HighlightModel.fromJson(res);
      return highlightModel;
    });
  }

  Future<HighlightModel> getPopularContent() async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlPopular(), headers: header)
        .then((dynamic res) {
      highlightModel = HighlightModel.fromJson(res);
      return highlightModel;
    });
  }

  Future<PerKabModel> getTotalPerKab() async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlTotalPerKab(), headers: header)
        .then((dynamic res) {
      perKabModel = PerKabModel.fromJson(res);
      return perKabModel;
    });
  }
}
