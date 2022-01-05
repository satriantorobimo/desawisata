import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/pertanyaan_model.dart';

import 'package:flutter/material.dart';
import 'bloc.dart';
import 'package:rxdart/rxdart.dart';

class PertanyaanBloc extends Bloc<PertanyaanEvent, PertanyaanState> {
  PertanyaanBloc({@required this.tempatDetailRepo})
      : assert(tempatDetailRepo != null),
        super(PertanyaanInitial());

  final TempatDetailRepo tempatDetailRepo;
  PertanyaanModel reviewModel;

  PertanyaanState get initialListPertanyaan => PertanyaanInitial();

  @override
  Stream<Transition<PertanyaanEvent, PertanyaanState>> transformEvents(
    Stream<PertanyaanEvent> events,
    TransitionFunction<PertanyaanEvent, PertanyaanState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PertanyaanState> mapEventToState(
    PertanyaanEvent event,
  ) async* {
    final PertanyaanState currentState = state;
    if (event is GetPertanyaan && !_hasReachedMax(currentState)) {
      yield PertanyaanLoading();
      try {
        if (currentState is PertanyaanInitial) {
          reviewModel = await tempatDetailRepo.getPertanyaan(
              event.id, event.limit, event.page);
          if (reviewModel.items.isNotEmpty)
            yield PertanyaanLoaded(
              items: reviewModel.items,
              hasReachedMax: false,
            );
          else
            yield const PertanyaanError('no_data');

          return;
        }
        if (currentState is PertanyaanLoaded) {
          reviewModel = await tempatDetailRepo.getPertanyaan(
              event.id, event.limit, event.page);
          yield reviewModel.items.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PertanyaanLoaded(
                  items: currentState.items + reviewModel.items,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        print(e);
        yield PertanyaanError(e.toString());
      }
    }
  }

  bool _hasReachedMax(PertanyaanState state) =>
      state is PertanyaanLoaded && state.hasReachedMax;
}
