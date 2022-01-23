import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/list_ulasan/domain/repo/list_ulasan_repo.dart';
import 'package:desa_wisata_nusantara/feature/list_ulasan/model/my_question_model.dart';
import 'package:desa_wisata_nusantara/feature/list_ulasan/model/my_review_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';
import 'package:rxdart/rxdart.dart';

class ListUlasanBloc extends Bloc<ListUlasanEvent, ListUlasanState> {
  ListUlasanBloc({@required this.listUlasanRepo})
      : assert(listUlasanRepo != null),
        super(ListUlasanInitial());

  final ListUlasanRepo listUlasanRepo;
  MyReviewModel myReviewModel;
  MyQuestionModel myQuestionModel;

  ListUlasanState get initialListListUlasan => ListUlasanInitial();

  @override
  Stream<Transition<ListUlasanEvent, ListUlasanState>> transformEvents(
    Stream<ListUlasanEvent> events,
    TransitionFunction<ListUlasanEvent, ListUlasanState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ListUlasanState> mapEventToState(
    ListUlasanEvent event,
  ) async* {
    final ListUlasanState currentState = state;
    if (event is GetMyReview && !_hasReachedMax(currentState)) {
      yield ListUlasanLoading();
      try {
        if (currentState is ListUlasanInitial) {
          myReviewModel =
              await listUlasanRepo.getMyReview(event.limit, event.page);
          if (myReviewModel.items.isNotEmpty)
            yield MyReviewLoaded(
              items: myReviewModel.items,
              hasReachedMax: false,
            );
          else
            yield const ListUlasanError('no_data');

          return;
        }
        if (currentState is MyReviewLoaded) {
          myReviewModel =
              await listUlasanRepo.getMyReview(event.limit, event.page);
          yield myReviewModel.items.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : MyReviewLoaded(
                  items: currentState.items + myReviewModel.items,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        print(e);
        yield ListUlasanException(e.toString());
      }
    }

    if (event is GetMyQuestion && !_hasReachedMaxQuestion(currentState)) {
      yield ListUlasanLoading();
      try {
        if (currentState is ListUlasanInitial) {
          myQuestionModel =
              await listUlasanRepo.getMyQuestion(event.limit, event.page);
          if (myQuestionModel.items.isNotEmpty)
            yield MyQuestionLoaded(
              items: myQuestionModel.items,
              hasReachedMax: false,
            );
          else
            yield const ListUlasanError('no_data');

          return;
        }
        if (currentState is MyQuestionLoaded) {
          myQuestionModel =
              await listUlasanRepo.getMyQuestion(event.limit, event.page);
          yield myQuestionModel.items.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : MyQuestionLoaded(
                  items: currentState.items + myQuestionModel.items,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        print(e);
        yield ListUlasanException(e.toString());
      }
    }
  }

  bool _hasReachedMax(ListUlasanState state) =>
      state is MyReviewLoaded && state.hasReachedMax;

  bool _hasReachedMaxQuestion(ListUlasanState state) =>
      state is MyQuestionLoaded && state.hasReachedMax;
}
