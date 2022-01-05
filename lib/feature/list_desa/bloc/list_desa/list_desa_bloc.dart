import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/list_desa/domain/repo/list_desa_repo.dart';
import 'package:desa_wisata_nusantara/feature/list_desa/model/list_desa_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/review_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';
import 'package:rxdart/rxdart.dart';

class ListDesaBloc extends Bloc<ListDesaEvent, ListDesaState> {
  ListDesaBloc({@required this.listDesaRepo})
      : assert(listDesaRepo != null),
        super(ListDesaInitial());

  final ListDesaRepo listDesaRepo;
  ListDesaModel listDesaModel;

  ListDesaState get initialListListDesa => ListDesaInitial();

  @override
  Stream<Transition<ListDesaEvent, ListDesaState>> transformEvents(
    Stream<ListDesaEvent> events,
    TransitionFunction<ListDesaEvent, ListDesaState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ListDesaState> mapEventToState(
    ListDesaEvent event,
  ) async* {
    final ListDesaState currentState = state;
    if (event is GetListDesa && !_hasReachedMax(currentState)) {
      yield ListDesaLoading();
      try {
        if (currentState is ListDesaInitial) {
          listDesaModel =
              await listDesaRepo.getListDesa(event.id, event.limit, event.page);
          if (listDesaModel.items.isNotEmpty)
            yield ListDesaLoaded(
              items: listDesaModel.items,
              hasReachedMax: false,
            );
          else
            yield const ListDesaError('no_data');

          return;
        }
        if (currentState is ListDesaLoaded) {
          listDesaModel =
              await listDesaRepo.getListDesa(event.id, event.limit, event.page);
          yield listDesaModel.items.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ListDesaLoaded(
                  items: currentState.items + listDesaModel.items,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        print(e);
        yield ListDesaError(e.toString());
      }
    }
  }

  bool _hasReachedMax(ListDesaState state) =>
      state is ListDesaLoaded && state.hasReachedMax;
}
