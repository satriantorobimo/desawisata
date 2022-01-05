import 'package:desa_wisata_nusantara/feature/onboard/model/onboarding_model.dart';
import 'package:desa_wisata_nusantara/resources/url_string.dart';
import 'package:desa_wisata_nusantara/util/network_util.dart';

class OnboaringApi {
  OnboardingModel onboardingModel;

  NetworkUtil netUtil = NetworkUtil();
  UrlString urlString = UrlString();

  Future<OnboardingModel> getImageOnboarding() async {
    final Map<String, String> header = urlString.getHeaderTypeBasic();
    return await netUtil
        .get(urlString.getUrlGetOnboarding(), headers: header)
        .then((dynamic res) {
      onboardingModel = OnboardingModel.fromJson(res);
      return onboardingModel;
    });
  }
}
