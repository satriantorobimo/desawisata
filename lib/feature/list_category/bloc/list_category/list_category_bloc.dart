import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/list_category/domain/repo/list_category_repo.dart';
import 'package:desa_wisata_nusantara/feature/list_category/model/list_category_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';
import 'package:rxdart/rxdart.dart';

class ListCategoryBloc extends Bloc<ListCategoryEvent, ListCategoryState> {
  ListCategoryBloc({@required this.listCategoryRepo})
      : assert(listCategoryRepo != null),
        super(ListCategoryInitial());

  final ListCategoryRepo listCategoryRepo;
  ListCategoryModel listCategoryModel;

  ListCategoryState get initialListListCategory => ListCategoryInitial();

  @override
  Stream<Transition<ListCategoryEvent, ListCategoryState>> transformEvents(
    Stream<ListCategoryEvent> events,
    TransitionFunction<ListCategoryEvent, ListCategoryState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ListCategoryState> mapEventToState(
    ListCategoryEvent event,
  ) async* {
    final ListCategoryState currentState = state;
    if (event is GetListCategory && !_hasReachedMax(currentState)) {
      yield ListCategoryLoading();
      try {
        if (currentState is ListCategoryInitial) {
          listCategoryModel = await listCategoryRepo.getListCategory(
              event.id, event.limit, event.page);
          if (listCategoryModel.items.isNotEmpty)
            yield ListCategoryLoaded(
              items: listCategoryModel.items,
              hasReachedMax: false,
            );
          else
            yield const ListCategoryError('no_data');

          return;
        }
        if (currentState is ListCategoryLoaded) {
          listCategoryModel = await listCategoryRepo.getListCategory(
              event.id, event.limit, event.page);
          yield listCategoryModel.items.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ListCategoryLoaded(
                  items: currentState.items + listCategoryModel.items,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        print(e);
        yield ListCategoryError(e.toString());
      }
    }
  }

  bool _hasReachedMax(ListCategoryState state) =>
      state is ListCategoryLoaded && state.hasReachedMax;
}
