import 'package:desa_wisata_nusantara/feature/home/domain/api/highlight_api.dart';
import 'package:desa_wisata_nusantara/feature/home/model/highlight_model.dart';
import 'package:desa_wisata_nusantara/feature/home/model/per_kab_model.dart';

class HighlightRepo {
  final HighlightApi highlightApi = HighlightApi();

  Future<HighlightModel> getHighlightContent() =>
      highlightApi.getHighlightContent();

  Future<HighlightModel> getPopularContent() =>
      highlightApi.getPopularContent();
  Future<PerKabModel> getTotalPerKab() => highlightApi.getTotalPerKab();
}
