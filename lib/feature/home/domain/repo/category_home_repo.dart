import 'package:desa_wisata_nusantara/feature/home/domain/api/category_home_api.dart';
import 'package:desa_wisata_nusantara/feature/home/model/category_home_model.dart';

class CategoryHomeRepo {
  final CategoryHomeApi categoryHomeApi = CategoryHomeApi();

  Future<CategoryHomeModel> getCategoryHome() =>
      categoryHomeApi.getCategoryHome();
}
