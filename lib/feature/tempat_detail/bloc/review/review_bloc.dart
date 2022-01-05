import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/review_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';
import 'package:rxdart/rxdart.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc({@required this.tempatDetailRepo})
      : assert(tempatDetailRepo != null),
        super(ReviewInitial());

  final TempatDetailRepo tempatDetailRepo;
  ReviewModel reviewModel;

  ReviewState get initialListReview => ReviewInitial();

  @override
  Stream<Transition<ReviewEvent, ReviewState>> transformEvents(
    Stream<ReviewEvent> events,
    TransitionFunction<ReviewEvent, ReviewState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ReviewState> mapEventToState(
    ReviewEvent event,
  ) async* {
    final ReviewState currentState = state;
    if (event is GetReview && !_hasReachedMax(currentState)) {
      yield ReviewLoading();
      try {
        if (currentState is ReviewInitial) {
          reviewModel = await tempatDetailRepo.getReview(
              event.id, event.limit, event.page);
          if (reviewModel.items.isNotEmpty)
            yield ReviewLoaded(
                items: reviewModel.items,
                hasReachedMax: false,
                reviewModel: reviewModel);
          else
            yield const ReviewError('no_data');

          return;
        }
        if (currentState is ReviewLoaded) {
          reviewModel = await tempatDetailRepo.getReview(
              event.id, event.limit, event.page);
          yield reviewModel.items.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ReviewLoaded(
                  items: currentState.items + reviewModel.items,
                  hasReachedMax: false,
                  reviewModel: reviewModel);
        }
      } catch (e) {
        print(e);
        yield ReviewError(e.toString());
      }
    }
  }

  bool _hasReachedMax(ReviewState state) =>
      state is ReviewLoaded && state.hasReachedMax;
}
