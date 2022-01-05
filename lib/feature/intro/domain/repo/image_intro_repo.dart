import 'package:desa_wisata_nusantara/feature/intro/domain/api/image_intro_api.dart';
import 'package:desa_wisata_nusantara/feature/intro/model/image_intro_model.dart';

class ImageIntroRepo {
  final ImageIntroApi imageIntroApi = ImageIntroApi();

  Future<ImageIntroModel> getImageIntro() => imageIntroApi.getImageIntro();
}
