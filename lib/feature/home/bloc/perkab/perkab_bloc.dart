import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/home/domain/repo/highlight_repo.dart';
import 'package:desa_wisata_nusantara/feature/home/model/per_kab_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class PerKabBloc extends Bloc<PerKabEvent, PerKabState> {
  PerKabBloc({@required this.highlightRepo})
      : assert(highlightRepo != null),
        super(PerKabInitial());

  PerKabModel perKabModel;
  final HighlightRepo highlightRepo;

  PerKabState get initialState => PerKabInitial();

  @override
  Stream<PerKabState> mapEventToState(
    PerKabEvent event,
  ) async* {
    if (event is GetTotalPerKab) {
      yield PerKabLoading();
      try {
        perKabModel = await highlightRepo.getTotalPerKab();
        if (perKabModel.status) {
          yield PerKabLoaded(perKabModel: perKabModel);
        } else {
          yield PerKabError('no_data');
        }
      } catch (e) {
        yield PerKabException('error');
      }
    }
  }
}
