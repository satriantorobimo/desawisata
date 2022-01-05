import 'package:desa_wisata_nusantara/feature/intro/model/image_intro_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';

class ImageIntroApi {
  ImageIntroModel imageIntroModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<ImageIntroModel> getImageIntro() async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();
    return await netUtil
        .get(urlString.getUrlImageIntro(), headers: header)
        .then((dynamic res) {
      imageIntroModel = ImageIntroModel.fromJson(res);
      return imageIntroModel;
    });
  }
}
