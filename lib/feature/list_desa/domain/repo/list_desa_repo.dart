import 'package:desa_wisata_nusantara/feature/list_desa/domain/api/list_desa_api.dart';
import 'package:desa_wisata_nusantara/feature/list_desa/model/list_desa_model.dart';

class ListDesaRepo {
  final ListDesaApi listDesaApi = ListDesaApi();

  Future<ListDesaModel> getListDesa(String id, int limit, int page) =>
      listDesaApi.getListDesa(id, limit, page);
}
