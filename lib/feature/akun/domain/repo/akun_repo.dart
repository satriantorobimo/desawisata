import 'package:desa_wisata_nusantara/feature/akun/domain/api/akun_api.dart';
import 'package:desa_wisata_nusantara/feature/akun/model/akun_model.dart';
import 'package:desa_wisata_nusantara/feature/akun/model/logout_model.dart';

class AkunRepo {
  final AkunApi akunApi = AkunApi();

  Future<AkunModel> getAkun() => akunApi.getAkun();

  Future<LogoutModel> attemptLogout() => akunApi.attemptLogout();
}
