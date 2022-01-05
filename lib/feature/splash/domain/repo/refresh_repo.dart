import 'package:desa_wisata_nusantara/feature/splash/domain/api/refresh_api.dart';
import 'package:desa_wisata_nusantara/feature/splash/model/refresh_model.dart';

class RefreshRepo {
  final RefreshApi refreshApi = RefreshApi();

  Future<RefreshModel> attemptRefresh() => refreshApi.attemptRefresh();
}
