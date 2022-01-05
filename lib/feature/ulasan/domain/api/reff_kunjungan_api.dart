import 'package:desa_wisata_nusantara/feature/ulasan/model/reff_kunjugan_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';

class ReffKunjunganApi {
  ReffKunjunganModel reffKunjunganModel;
  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<ReffKunjunganModel> getReffKunjungan() async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlReffKunjungan(), headers: header)
        .then((dynamic res) {
      reffKunjunganModel = ReffKunjunganModel.fromJson(res);
      return reffKunjunganModel;
    });
  }
}
