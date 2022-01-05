import 'package:desa_wisata_nusantara/feature/list_category/domain/api/list_category_api.dart';
import 'package:desa_wisata_nusantara/feature/list_category/model/list_category_model.dart';

class ListCategoryRepo {
  final ListCategoryApi listCategoryApi = ListCategoryApi();

  Future<ListCategoryModel> getListCategory(String id, int limit, int page) =>
      listCategoryApi.getListCategory(id, limit, page);
}
