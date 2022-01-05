import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/api/tempat_detail_api.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/get_likes_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/pertanyaan_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/review_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_likes_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_question_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_review_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/tempat_detail_model.dart';

class TempatDetailRepo {
  final TempatDetailApi tempatDetailApi = TempatDetailApi();

  Future<TempatDetailModel> getTempatDetail(String id) =>
      tempatDetailApi.getTempatDetail(id);

  Future<ReviewModel> getReview(String id, int limit, int page) =>
      tempatDetailApi.getReview(id, limit, page);

  Future<PertanyaanModel> getPertanyaan(String id, int limit, int page) =>
      tempatDetailApi.getPertanyaan(id, limit, page);

  Future<SubmitReviewModel> submitReview(
          String fileName1,
          String fileName2,
          String fileName3,
          String wisataId,
          double ratingPoint,
          String visitedAt,
          String review,
          String title,
          String visitedWith) =>
      tempatDetailApi.submitReview(fileName1, fileName2, fileName3, wisataId,
          ratingPoint, visitedAt, review, title, visitedWith);

  Future<SubmitQuestionModel> submitQuestion(String id, String value) =>
      tempatDetailApi.submitQuestion(id, value);

  Future<GetLikesModel> getLikes(String id, String imei) =>
      tempatDetailApi.getLikes(id, imei);

  Future<SubmitLikesModel> submitLikes(String id, bool isLiked, String imei) =>
      tempatDetailApi.submitLikes(id, isLiked, imei);
}
