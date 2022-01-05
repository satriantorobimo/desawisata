import 'package:desa_wisata_nusantara/feature/search/domain/api/search_api.dart';
import 'package:desa_wisata_nusantara/feature/search/model/search_model.dart';

class SearchRepo {
  final SearchApi searchApi = SearchApi();

  Future<SearchModel> getSearchValue(String value) =>
      searchApi.getSearchValue(value);
}
