import 'package:desa_wisata_nusantara/feature/list_ulasan/domain/api/list_ulasan_api.dart';
import 'package:desa_wisata_nusantara/feature/list_ulasan/model/my_question_model.dart';
import 'package:desa_wisata_nusantara/feature/list_ulasan/model/my_review_model.dart';

class ListUlasanRepo {
  final ListUlasanApi listUlasanApi = ListUlasanApi();

  Future<MyReviewModel> getMyReview(int limit, int page) =>
      listUlasanApi.getMyReview(limit, page);

  Future<MyQuestionModel> getMyQuestion(int limit, int page) =>
      listUlasanApi.getMyQuestion(limit, page);
}
