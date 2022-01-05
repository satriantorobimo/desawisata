import 'package:desa_wisata_nusantara/feature/desa_detail/domain/api/desa_detail_api.dart';
import 'package:desa_wisata_nusantara/feature/desa_detail/model/desa_detail_model.dart';

class DesaDetailRepo {
  final DesaDetailApi desaDetailApi = DesaDetailApi();

  Future<DesaDetailModel> getDetailDesa(String id) =>
      desaDetailApi.getDetailDesa(id);
}
