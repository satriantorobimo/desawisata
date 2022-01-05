import 'package:desa_wisata_nusantara/feature/ulasan/domain/api/reff_kunjungan_api.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/model/reff_kunjugan_model.dart';

class ReffKunjunganRepo {
  final ReffKunjunganApi reffKunjunganApi = ReffKunjunganApi();

  Future<ReffKunjunganModel> getReffKunjungan() =>
      reffKunjunganApi.getReffKunjungan();
}
