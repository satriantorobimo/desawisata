import 'package:desa_wisata_nusantara/feature/desa_detail/model/desa_detail_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';

class DesaDetailApi {
  DesaDetailModel desaDetailModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<DesaDetailModel> getDetailDesa(String id) async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlDesaDetail(id), headers: header)
        .then((dynamic res) {
      desaDetailModel = DesaDetailModel.fromJson(res);
      return desaDetailModel;
    });
  }
}
