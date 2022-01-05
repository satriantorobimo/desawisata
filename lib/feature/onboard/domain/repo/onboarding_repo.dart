import 'package:desa_wisata_nusantara/feature/onboard/domain/api/onboarding_api.dart';
import 'package:desa_wisata_nusantara/feature/onboard/model/onboarding_model.dart';

class OnboardingRepo {
  final OnboaringApi onboaringApi = OnboaringApi();

  Future<OnboardingModel> getImageOnboarding() =>
      onboaringApi.getImageOnboarding();
}
