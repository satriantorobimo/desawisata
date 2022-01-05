import 'package:desa_wisata_nusantara/feature/search/model/search_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';

class SearchApi {
  SearchModel searchModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<SearchModel> getSearchValue(String value) async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlSearch(value), headers: header)
        .then((dynamic res) {
      searchModel = SearchModel.fromJson(res);
      return searchModel;
    }).catchError((e) => print(3));
  }
}
