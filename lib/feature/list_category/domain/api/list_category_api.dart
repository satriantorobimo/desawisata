import 'package:desa_wisata_nusantara/feature/list_category/model/list_category_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';

class ListCategoryApi {
  ListCategoryModel listCategoryModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<ListCategoryModel> getListCategory(
      String id, int limit, int page) async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlGetListCategory(id, limit, page), headers: header)
        .then((dynamic res) {
      listCategoryModel = ListCategoryModel.fromJson(res);
      return listCategoryModel;
    });
  }
}
