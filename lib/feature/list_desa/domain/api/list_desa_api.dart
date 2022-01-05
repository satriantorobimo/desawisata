import 'package:desa_wisata_nusantara/feature/list_desa/model/list_desa_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';

class ListDesaApi {
  ListDesaModel listDesaModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<ListDesaModel> getListDesa(String id, int limit, int page) async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlGetListDesa(id, limit, page), headers: header)
        .then((dynamic res) {
      listDesaModel = ListDesaModel.fromJson(res);
      return listDesaModel;
    });
  }
}
