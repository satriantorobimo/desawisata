import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_review_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class SubmitReviewBloc extends Bloc<SubmitReviewEvent, SubmitReviewState> {
  SubmitReviewBloc({@required this.tempatDetailRepo})
      : assert(tempatDetailRepo != null),
        super(SubmitReviewInitial());

  SubmitReviewModel submitReviewModel;
  final TempatDetailRepo tempatDetailRepo;

  SubmitReviewState get initialState => SubmitReviewInitial();

  @override
  Stream<SubmitReviewState> mapEventToState(
    SubmitReviewEvent event,
  ) async* {
    if (event is AttemptSubmitReview) {
      yield SubmitReviewLoading();
      try {
        submitReviewModel = await tempatDetailRepo.submitReview(
            event.fileName1,
            event.fileName2,
            event.fileName3,
            event.wisataId,
            event.ratingPoint,
            event.visitedAt,
            event.review,
            event.title,
            event.visitedWith);
        if (submitReviewModel.status) {
          yield SubmitReviewLoaded(submitReviewModel: submitReviewModel);
        } else {
          yield SubmitReviewError('no_data');
        }
      } catch (e) {
        yield SubmitReviewException('error');
      }
    }
  }
}
