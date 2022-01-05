import 'package:desa_wisata_nusantara/feature/home/model/category_home_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';

class CategoryHomeApi {
  CategoryHomeModel categoryHomeModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<CategoryHomeModel> getCategoryHome() async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();

    return await netUtil
        .get(urlString.getUrlCategoryHome(), headers: header)
        .then((dynamic res) {
      categoryHomeModel = CategoryHomeModel.fromJson(res);
      return categoryHomeModel;
    });
  }
}
